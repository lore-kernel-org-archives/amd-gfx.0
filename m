Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2EAC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA78112DE7;
	Tue, 30 Apr 2024 18:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z8Lq2juX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87457112DE7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adjYaG5GZqzxefP33yRG/kl2x4ocgrUVAMFkF7MubVNsl+HRoxl9YglLsG+8LayhjjdTs19xbMZZcb0DDSnc+14yWyyXVADNJEPwrMSAZRt/ug4R0WVa0Gnw3f0OFasuSw7nMnUfhRU8oCinhCFTDJOspl5VTaBjIjX/+0F8wp7DVhbU79n395xWRXqTnhNmgNro3q/L31EGqwlhs0yLcEnThHyJV88tr/PEd3g5OLNjKBIed65i07/6RZAUDYD1JaEmewgvU9k3ra/5hMduE8V1bMWeEBP+xIGda2ufJBX3QiYGALP2BOsMIcKOvMvnajpcl0S0rqoL+T3TymFo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yi0N1QcTsp0wdLMkRSn2rKk/76cpkSsFRbXVCYg1Yo=;
 b=fWjD6Xjdv4wHLemJmoZLl5eHk1oEklHWpVgO0C/xE7xKm+fsAtZUtYTpqZouBxNWJXZp98YQbZlV8YVHeu9hAChAJ50ET3QlQYSUjcqHVSCDq/ockv+eyhf1qJHKBNwjM29kU25/sRNyH565KVJBzs7jHKIJUkRxZiNAURf206LFvxfQ+rcIbRgM3ww54Ml+ACoaw5UqrqDFOvkdWPBKi73oUjSSm4v+SMFLo3FDrxtj6BXobDU4yhro89HFbQLGgoenNz6do3WIf8F+CUQofED4QxNemK+sIzUGZhuu5+WL5RINAHzIy+oMhu1CA8r4d6otfNRkg6yvSjnh/owe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yi0N1QcTsp0wdLMkRSn2rKk/76cpkSsFRbXVCYg1Yo=;
 b=z8Lq2juXyPT/vu5d85Q3zFDD8BOKyC+7rE/UOKaFSYYIQvh5aDhzIRueqVZX4xTVDWB6Np5+a/wdGKQvafMvT0XQkLRd94R0AF/ipIEhlSIw6oN74MzTExrm0hSD0xGQKUy4zOmM2ivCWA7JJeNfThCrl9z4gmfWjvnyXt6tsU0=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Tue, 30 Apr
 2024 18:32:43 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c%5]) with mapi id 15.20.7519.030; Tue, 30 Apr 2024
 18:32:43 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
Thread-Topic: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
Thread-Index: AQHal44d35rXXwjLWEqH9/3xY/dKjrGBKlxw
Date: Tue, 30 Apr 2024 18:32:43 +0000
Message-ID: <DM4PR12MB5328E4ED39F319F921E10973F11A2@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <20240426035742.90560-4-Yunxiang.Li@amd.com>
In-Reply-To: <20240426035742.90560-4-Yunxiang.Li@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a982f684-6f3b-4a10-973b-e8920f106062;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T18:32:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|DS0PR12MB6535:EE_
x-ms-office365-filtering-correlation-id: cd38581a-0c31-47da-150f-08dc6943ece3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?RI33hTFunb63DjhMMjP5HLEbhk1iZgh9h9ka0++c2I14ENB8hofk4ljQtH3k?=
 =?us-ascii?Q?0f2GyjO6MTmke+tj5DI2I/uHYN5rkwTmAJKoeUWFyVNbDhxPVWljvdum6deL?=
 =?us-ascii?Q?R1TBAV6XsBBbtajS+bmkjIMlB/4YVoLjLao8g4zF6zccJjmJ/6KqWdeR4uNF?=
 =?us-ascii?Q?Vx4Oh0hT70xothdEpemQYJWdmDXLihmTjerVtbbd64JSIBV7Y+eD6nopxOAO?=
 =?us-ascii?Q?c5G8UsrYA0xugTvh42aykgTo9/mO93n9Mc7F3wGXWMpH83tCTJII6WFGVonK?=
 =?us-ascii?Q?2BvSzdv8EHUqmU2T1kNrHYRyiiq+ImMKoejmJGsunoz9Fms5Nz09Ip6sUqLX?=
 =?us-ascii?Q?oSm7uA6bXeK7DMiPxNMGQYGdBm3z0GZxfZMFmTSXC+X+LVH73sdgnkeY8eLH?=
 =?us-ascii?Q?9kxj25M2rrEPk42vDHvLirA9YHnfVRHXy1IThf0h8IgCKozK80jPX5sGU4JT?=
 =?us-ascii?Q?IgimqybWJN6mZSrJ+/WvUi8HMynusnyHEAp0sApaYdMJnmOj7gXAFiE2PCst?=
 =?us-ascii?Q?k1gINJwH2BOXL/kotmGL7cUXtMjwRoRrP26HDdF2v6FFysyZoLUO/Oq0Nkax?=
 =?us-ascii?Q?GgQHa2upz63/Jg7ZsKFXgc8xPP4OO14lJUjzg2ji1bwm0LdnQEs/R9bXPJP2?=
 =?us-ascii?Q?vN61CX6JXRN3UjV9Ovk09QOes2AnoCpvh7ZhLhtodI3KZ5dRg/UiO02z3yLv?=
 =?us-ascii?Q?alMsfj1ZhNeKuKHXOW17yasbvrRCvpOM4izyfrqKP8aMUVFUrvTJzC0SonPR?=
 =?us-ascii?Q?Jy5/eXz2C3FBTUvVD1NW19xrpVMeKBCivbzm3w6sOHC143DCbvhZuDC6Ky7c?=
 =?us-ascii?Q?t2SCHwh2vmoxzTC70N4AiPvYetHKLzdBLDNTw68gEunghtRxF/xyxpLfHnjV?=
 =?us-ascii?Q?gXYQub5qllzAglvVG5WzSpAaPmbUWHcOnzUsnJBNS4xIbGTK2H8lVk6T1mYE?=
 =?us-ascii?Q?x5smUPun8vU1CLBFLgs7Y/HVGTgxVce2kPQfAFnOJRYSPn1GIPU1EraNbmsZ?=
 =?us-ascii?Q?Wj+f9MZlAqm5mGdWLkBX0crcm0pyjh90WTXvaZWrr9U38bUZl1crI08JFD//?=
 =?us-ascii?Q?7iFtuqvB4UI+HVceNTdP4O7gvdYTK3V6xfful139g89rol98Gfccb1F/CsdE?=
 =?us-ascii?Q?Ino9+pGTYfBakn5AGbEbqFwJo40jRG78K8IJ83rA6HUGx+/vMy9I852+85eN?=
 =?us-ascii?Q?ad5Ng2/V20CEJDJZK7AID4m0uybrfdHKg3gxTc8aWMJTyU6CCsvqOvMSPpVt?=
 =?us-ascii?Q?rm78wln2WORkdTAk/hbn4e9titcnzdVdOtsGWjuyavgjUEdcH/wkLzSqKjud?=
 =?us-ascii?Q?TvnMG/X7YE1xMXyPaJEiZYYlru2YH/ybWgDsIqkbum2PwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QH9ZsbDuQ3gP5E2cImYg4VTzffOO+GFmpV2Bg6hfrRhV/Ejvw+0iRngFIs7i?=
 =?us-ascii?Q?BSESkPowD2c/HmiK7cB+URxvMbiQJO2l1OTFC1aw+cB68Q17iIMsRV/TqXkN?=
 =?us-ascii?Q?ds94olY9VvENaJaRwdXdmERyOej4T+wzR+JkCrkzT0aUpcAdOXQy8bP3Eipy?=
 =?us-ascii?Q?hpa6IXlSdCL+Y/Ihsfy7XaoPvkXl1vwKhSzMrD2NwEkFI1NvBN8UQpszVNhr?=
 =?us-ascii?Q?4t1eInVAoliDQUXEpc2nxRKfSbjr9aQZrz4nZfAZVd8rjJ2lf+zsTzfbH2iA?=
 =?us-ascii?Q?+e2PfRZRMv81xb77lnUiBW228TawoAHMM1NI3mTb1zwu5GvVv1dbVAf3FzJP?=
 =?us-ascii?Q?5WBOQ1ofOEvfgt4p/aJH1+Rgm394qGW9qO65ZHwd0jOCojQg9Nijhwuc0qXp?=
 =?us-ascii?Q?mFyKkWTG3C3jBkWR4/NiYf42CK3nrPszac+Br3kc0aIdLfqpMsSjPnBDAyUb?=
 =?us-ascii?Q?qBvKKSAE/Uq935iyCPba4+iRkMvJPDz9rMTROv/VRtwM96+FYhOnET5A9AX/?=
 =?us-ascii?Q?nUg/+76U61w7WxhSqP5GJLFQEWGcNXjzR4Qf58I6htja+zaZs9lur76oENt1?=
 =?us-ascii?Q?5xq0l3cjN7bDpjLJHH0NKaBW0VQaIajkVIjgi7fIOn8v56g8JKhhWo+h6DSk?=
 =?us-ascii?Q?DnNfvDDI6SxR/ihXcwhff+NnJH4Uzx61yHVtBNIFrmylXpw43EhA6ghPydZu?=
 =?us-ascii?Q?EjeTM62K7ALt6paYXL7X4lluxbYxF/qKv1yu6y0uzqIX0wKQpEodH0zLacXL?=
 =?us-ascii?Q?3DOPIcO3RfNPZrmzlHw/F4J4AKBmT23AVtWCuDBTxz0ixY1E9q0TzmZ53+yt?=
 =?us-ascii?Q?VHcxRqctiaInyzzHvlLUzYQzuQ7a3+IpvLFlMrmq/OrrGZ6aIKh/bmv2aGBO?=
 =?us-ascii?Q?n0vfvtJD1JqKeQhQafchbLGXKyr/JaIIXnUmSZr0ITsuHPslIeS/1+S3CnrV?=
 =?us-ascii?Q?4dxQFUqQxcZRi8Sp5icb2wjt+1YvZpz9X3ayKgTUi6KLVl+5etnIMgKwVSr6?=
 =?us-ascii?Q?g4R1/9eLFoXziKaxNBOYfxhoEgmW0M+lcQj4BRXJ76Ht2xox3qZ94mvV5uNS?=
 =?us-ascii?Q?7kVPwIaoPDk4UGakK4o7vwDSzMrGdsGTDEzzjrxxR9QTvPHOMMsn+wtcQuJk?=
 =?us-ascii?Q?O6q4yhI0qm/Par0qiqEuo+c3OTZ6AIABzw0JSGBHmuq9ZLf6yVaOTlD4pQBz?=
 =?us-ascii?Q?F30E6EjaZPMhhRn46v7NRXOQ423356Wxo45lfKHIeKD8HGg78dtvnqz9ogAh?=
 =?us-ascii?Q?cp9V8KNApIlNUUi+xJsUtDZACymbXhP+Sr4o5NowpWNLVdhZtQ8uHuiq0sWu?=
 =?us-ascii?Q?puJLzUnBTPlr959VVBIaYKxg52yF5f/yoTyqSxKpJDROeYKXJgKWr7oc2Tlq?=
 =?us-ascii?Q?iiHMOkEojlfsvb+jmDmG2wjnEONj1aeZ0kPdTQU3NCb+07HZJ8thPufCcB9U?=
 =?us-ascii?Q?umYgr86rTgipKcLd11EGkumAyel3ZlOkbtfR2whcH3BcFBxFQx61yx7IRgPN?=
 =?us-ascii?Q?DcHR3E9dofdLBy3fG/lMshF4yYqT7xKq9145GMQ1Y22czfGFwtYBWTFqarik?=
 =?us-ascii?Q?zEhsT+X8ABa3CDUjKPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd38581a-0c31-47da-150f-08dc6943ece3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:32:43.7664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKwFxJZSMkpTrsYL3cz7qHidgBKBFNkWfSNmqnJtkZMgFGeqpTsVFmKLtSrFZ2GH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxiang=
 Li
Sent: Thursday, April 25, 2024 11:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling, Felix <F=
elix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li, Yunxiang (Ted=
dy) <Yunxiang.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function

This is part of the reset, move it into the reset function.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3c4755f3c116..8f2c1f71ed9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5119,6 +5119,11 @@ static int amdgpu_device_reset_sriov(struct amdgpu_d=
evice *adev,
        amdgpu_amdkfd_post_reset(adev);
        amdgpu_virt_release_full_gpu(adev, true);

+       /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ra=
s during reset */
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
)
+               amdgpu_ras_resume(adev);
        return 0;
 }

@@ -5823,13 +5828,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
                        goto retry;
                if (r)
                        adev->asic_reset_res =3D r;
-
-               /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need r=
esume ras during reset */
-               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
-                           IP_VERSION(9, 4, 2) ||
-                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 3) ||
-                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
1, 0, 3))
-                       amdgpu_ras_resume(adev);
        } else {
                r =3D amdgpu_do_asic_reset(device_list_handle, reset_contex=
t);
                if (r && r =3D=3D -EAGAIN)
--
2.34.1

