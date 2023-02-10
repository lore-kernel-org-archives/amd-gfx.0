Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA26C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 03:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E17C10E112;
	Fri, 10 Feb 2023 03:17:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D0010E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 03:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az/gNcVUp3kCnIkDfW2b4b5F33uk2enlK0lVXKBNQHvz0banC71U7cyARHNo+I8AyqRc9k+BHpcA3sulYVte0cTBcxZDZM8QqVEIvEvYqCBxiZraDNtxU3Pg55wcfmpFZO6hqRGoYwBSmUrmYExDkCtaX0He6hJPOzRMEQ4PWcN7fgxG4Hcmv94C9GmJDuxhWKAtQrjUHmVFV/gTtspRCdnHsNyowVCITzDWuNp7ykT+sCbo4lRFhMk4iLzikbm3Ah4YDNnsGSPUON0o+bTuvjkmVDj63KAcN2DuiemoJi96hozT6j/8f3yUg7Q282RmCpvikHv+BgcnTJadxzjdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa/i37eEe6mEDbj7mXfIjyeoMq0DD1pgCoeCsb1+O0Y=;
 b=XyNyC7ZIUIMmni3zhh2DA1yKsNyg+qkrGhfMBPnY1yPiKE95e19xR6kFNbOtRhTHen2X5Du3C8ovkh5/FoXXGFmyNcQwGhfeFvOgoYmSQ8+dZtBCRifGr83bNYyi5liEoy34/ZyrUKquys6JgFGY56m/E3xir7W7bG/ZudHq9DXxRDjR0ex27Mkl2+Y6oEMoI6lZ1N4QgNHsjl3tr/hB992wkqkwcCKpFO6ml3LJmgAKDJhHgRaQ+DeBKhH8amq/ujD4Et16k6ToIBRhhg3Q4CxaIApV2/o3da42m6FPe89lBUdZee2TdDofthufsDI3bVDpMKA8y7VNYQs8S0IwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa/i37eEe6mEDbj7mXfIjyeoMq0DD1pgCoeCsb1+O0Y=;
 b=De0xFrVVedVKy2aG3dIq25/q1rWaFY2NljpYArViDinpgB5JFYUDflRmNbgLOh2+B/qvCiLHK1rQWx4r/dpDYpTuQ1Ztgj/h0QWD33b8GgsPiSgauvPjS+kMgqSPJAWzh9vtP8hrmu1PMHFoPiQAAKHFIbxg3ZiQ3e9+JVDAt9A=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 03:17:02 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece%9]) with mapi id 15.20.6064.031; Fri, 10 Feb 2023
 03:17:02 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] Revert "drm/amd/display: disable S/G display on DCN
 3.1.5"
Thread-Topic: [PATCH 4/4] Revert "drm/amd/display: disable S/G display on DCN
 3.1.5"
Thread-Index: AQHZPJCHuCakPx0hDE+B2hPqPl8k+67Hgs3w
Date: Fri, 10 Feb 2023 03:17:01 +0000
Message-ID: <CY5PR12MB63698D2DFC1C46A64BFB191CC1DE9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230209141150.612825-1-alexander.deucher@amd.com>
 <20230209141150.612825-4-alexander.deucher@amd.com>
In-Reply-To: <20230209141150.612825-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-10T03:16:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b33730e-ac25-4676-9fa1-ce021fb8199f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-10T03:16:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ab3f54e8-1ba1-4b75-bd30-a4dd210062fe
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH2PR12MB4309:EE_
x-ms-office365-filtering-correlation-id: fc09b9d2-b19f-40ce-cf15-08db0b154727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsxY0iZAdl9XNBx+NIZUn+BuHpybfsi0MbPxh2y2Qxw3RzmC73+2yX0kZlckMoO6c6CNBGjEZoEfkf7ZdLA2zFAyVZzEVFrc2VTUsfXNKnSpklzKM5iTLlKVTaDg+Zz2+FJoFhKPStCYvqquJpLpo40dksclOmFhDG0bJbcP+xZDPoYpzR6ImpndSVwMPY7Fzn/SBNdQZg+If2qPjgOFNYFv3DzEmD+icpqTP1iOCEfO2x8obOEGkZfd0vwCFSA6L5XHXz/9px22Lsj6rS+8rLNOra1vkK+Cgcs2JfUvVB8P5pUoZPVy7Jzs+BUD2tt0y3rr4lBfbroO0cbLWQHdXBnjhwi8jUi81/mONg81iRPYLDT3lLQyXKBFDIoK7wlZxiEFLV+gvqTc0I6WsRVlp55zJq022Ya/LridnSY1ifHlnaNhMhDjEL++qd4FRqlQGhV2phldAbJ9GJE34VOZnTAaQacQPbDshbZikygkeYhe6PRUO9I4RYSifFg9O8hA1MaF6bwe5kQyfwYvYxjC7PLBsFmLVQu1m1DkTlYCXXctkmoVaESeB1hSJdmQEqBXwNe2aXBJJvfkdIjHXCH1QRQg8DZHw1N0avoozQuc6T55Rxn5IM7dJZRRgPs//LcNaDGv0eULBJyp37mZe/LcwM01Jv7Y/4MSRX6KvgMrAVXUUpD694kWAWRHPlPVKV9066d5ofve7zvy7ckpGRGtAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(110136005)(8936002)(4326008)(76116006)(316002)(8676002)(41300700001)(52536014)(66946007)(66476007)(64756008)(66446008)(66556008)(38070700005)(86362001)(33656002)(122000001)(38100700002)(186003)(9686003)(26005)(53546011)(6506007)(71200400001)(478600001)(7696005)(5660300002)(2906002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7xh9FL710jBfxPCQwCEChUZbpLzTmu72dnbd6ojuNZQ2M1iUOlZCeCppXSAB?=
 =?us-ascii?Q?RFsVdV41LQ+qzGp+cIA8mD6vveuwLNhbesDoieqyGSYWRIAvA/LjJV03qUFZ?=
 =?us-ascii?Q?DxAswTreSEr2EKKrsrHMoDQQu0Wejps6pTCzEBpouwTUp9VxYXxMOblz1Emz?=
 =?us-ascii?Q?mMYrVvezzaGUMqEueSTBqfosw1UGif/2XDZrnVYvCDLnopzdbq97TjrcDnxk?=
 =?us-ascii?Q?J+b9XlzE2qosmEX1cc4dmQXCeBIQb8vi2EoOxBY+BtKcQiVh8eIv5RzNWMEI?=
 =?us-ascii?Q?OpknUnAhkGzFJMNspOZu4TboNSAJfpkDbscVKJVa1DBPFo4oMzaFwVA6RJN+?=
 =?us-ascii?Q?GqMM7yGgK49J/CtXhXeXcehASgKNkrm/Ph3jZB0flKTroVdSjqWJSbEpPb3X?=
 =?us-ascii?Q?IkkbrSHE773dkJXXw7HlnhoQjEZMsjuBGVvbw7YCcu7vehKbRxMpH4Wdwwgb?=
 =?us-ascii?Q?ezwRSsfJljqoVQOezQh56lbNE2zsvPqbnzfVOV7q9ED9kXn0s4z/3fjoN7w3?=
 =?us-ascii?Q?vPLGtkywqJ8HXMi2/zM1mDRyNYDx/UlReUjQKhiwbeB+VT+8c5b4A8pEDAcl?=
 =?us-ascii?Q?Rm2+qpe9aQNzbZeNxfexbZU6XI9n777uhTJcWLFLEjX5DQcmHfGhNmX9NsI5?=
 =?us-ascii?Q?fljKB+2bYtQ5woMXRZf0l+ScRyiuTgEPYsw9Ro+oEC0d57afRyxM9agktT19?=
 =?us-ascii?Q?mcjb9/q0oEbN/0mFds3qXmi2FIxhnziJQziQuRhF7tBxZj/TiECj4wz3eEci?=
 =?us-ascii?Q?1zyJEkPZU2qfZlWjpFQOQSPEI1DRuZo4prWpzz619L+TQ3zGYg+Lzni09rlb?=
 =?us-ascii?Q?dJSj3uUcPiwVVESiVWPb4FR44KP5D3HfohoWdEfCWwPTkL2kERzPLD72zJTb?=
 =?us-ascii?Q?T78j4uGh6C37sccSaalX87wVQdDfG/ilQ/VtZP3RE9IWeeGgQ+li+58nVQyk?=
 =?us-ascii?Q?xhmxbuYQSAJubQBZdEqrYu79uIEWax23AUO0XEqKbkSRsZV+9JXCdNLm1+/t?=
 =?us-ascii?Q?lmeXES790iu0MIgU1yG4trKwokzjfqUTZ+N/wRadX8R4sjtTaZq9kA1D3u9N?=
 =?us-ascii?Q?CTOi2AmsXSZDcdRiy8bi+JOyLMSVnwsHhgeSRx6BN/Ke1rFcoyWfNZ57u33S?=
 =?us-ascii?Q?91hg8RQVSgpezNeD5ESgdpMoAx+2sJo4XTGOKV+oO78qvbubjxUQcA0vM+0P?=
 =?us-ascii?Q?fNQz4UJ/hXXVO4MMhS+rBgpBNlHVweB9mZmkSuYEvhWp7jLFGtuNz3FtUfT5?=
 =?us-ascii?Q?FgLILvfe2LE1pCAU7o8TYJnDMGG8U/q3O6dd/k8/y3ddYqH30HM0SgLY8KuM?=
 =?us-ascii?Q?9CSIg1dcPeZQNIDDpVOyw8lYsFpop8n4k0v5w4z04HUtFszvg3cjVTUf4CRM?=
 =?us-ascii?Q?RrpeWQjm4o/kUO45LPn26wKM30EGwDNT85Q7mjhGB8kKVhLYwHeUq/WSVILd?=
 =?us-ascii?Q?g/jN9Nt8cH9+e00bkiLvJiDVRUWep5M6Ljr3d0JoN3YhRUkDNIna0H+4ANmw?=
 =?us-ascii?Q?T7K4jMea4PUwv3VpwAKaXDp2kc/VT1oMZhPsqP4GHJBPi6aMPL/uVYw6jt8d?=
 =?us-ascii?Q?maLfPuiG8iXeFn4GHwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc09b9d2-b19f-40ce-cf15-08db0b154727
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 03:17:01.8754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zv+9/RrtdpCsH3em0XCuES6mMTR2VIqHl2uMDU0wQSEhW3sCKbx4bCP5TNuRpsSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is=20

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 9, 2023 10:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] Revert "drm/amd/display: disable S/G display on DCN 3.=
1.5"

This reverts commit 3cc67fe1b3aa1ac4720e002f2aa2d08c9199a584.

Some users have reported flickerng with S/G display.  We've tried extensive=
ly to reproduce and debug the issue on a wide variety of platform configura=
tions (DRAM bandwidth, etc.) and a variety of monitors, but so far have not=
 been able to.  We disabled S/G display on a number of platforms to address=
 this but that leads to failure to pin framebuffers errors and blank displa=
ys when there is memory pressure or no displays at all on systems with limi=
ted carveout (e.g., Chromebooks).
We have a parameter to disable this as a debugging option as a way for user=
s to disable this, depending on their use case, and for us to help debug th=
is further.  Having this enabled seems like the lesser of to evils.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f7ba65fd8f48..7f16be84f3b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1571,6 +1571,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support =3D true;
 			break;
--
2.39.1
