Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27817C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 10:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC8E10E048;
	Tue, 23 May 2023 10:40:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B6C10E048
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 10:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lossgOkg8SPI8RLLc38xUXFOll092ZcB6TN3bs6iOhhM+wUZosvCWWT1edzzCJdvWWAHO2Kst1G/oznMMnqBUima1U2fsY7moBf4dfMmFsoRQzbAzoY5Xt5JgsfsW1nuotWvPAyar1aWQSk8bOeG8FE/Ov8owOZirc4LyBT2htSKEGBevpSHQzTBpMtOORwJuiXIZijIjQiSoQQtVobK550crMdzkvrAt1z8+pjkDM8craelUOtyGnm220ZrRX+zMHppRdwe1uGczP6ATOq+TeNCoOshAVSIfUrLxyUs20001v+3ipFkNdTeAuncdyj/cr4VMJwbuehxKd3X5t3JFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBjq2gHl4mNzhM44G+BN0AUP9pJqMrDgwLJ4Ekkjjt4=;
 b=VxiNPjjKuEdM65akeN1bGheJ4cDJaGFuxkZ8elr0R02Ciy/oxnA3T/hA2qiyAshs4hjMsXFaqwRhyrbXTa1ZtS29Q667tzugcO+9OgHaI74m+JftvoFipFrsKLc39vDQLM8Okkztb24IyiauZj57Bn4kiDcBud9FDWjk+2jYJ8cgCqZAoOyN9saC22md7WNPQ3eaKsJVnJBIRRhyk+a+egXN1FR/YnxlfhQBtJQeXCgg/ieXpCs3ndBzfFCnT1NP3NqX7f9ozYQHTAXpcUOJN9W38ZCHqjhaaVHvoFBo/y43AEX1acy5s53x9cPgJjmlX1ncI8z0ywrohf8mMrx3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBjq2gHl4mNzhM44G+BN0AUP9pJqMrDgwLJ4Ekkjjt4=;
 b=kuTVGntkHxp8LwpCdeF7RCpfOKOWjYrtM9jv43CKZbZgU155d1mLL4NZ9DOSvw723p7eg3CONyOIh3PxZXXasburkG8wyOEyJj192/M4EXVK3+ed4Haiud7SBKflySUomf7srRHicp3vp7cUtq1Kc/YqQa5Lh1fnBRpDArCwyXs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 10:40:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:40:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix warnings
Thread-Topic: [PATCH] drm/amdgpu: Fix warnings
Thread-Index: AQHZjUyknNGoLdQRp0OhJZXk9faoiq9nqzcg
Date: Tue, 23 May 2023 10:40:21 +0000
Message-ID: <BN9PR12MB5257E649111DEA604476D4F9FC409@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230523075956.532333-1-lijo.lazar@amd.com>
In-Reply-To: <20230523075956.532333-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T10:40:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5fbc1b96-daf5-4707-9a21-d97faca9a02d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4436:EE_
x-ms-office365-filtering-correlation-id: c9aa2457-e74a-4ee9-1c30-08db5b7a1bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxvvqOgJKAGYgXVZ+ytklLFp5iJwHS4DdGzRjabbnkr6ue21e1a34p4SfYP57oCns7PQWy9KfvOOHZhYrMuwlehW8qfHLaNzPY9pJdDRAe+MtSExGBmu+LKiAp16ULniV44QAGrgYuHOsMV0Olaa+gwbDWMcxlw5ccc6oq46Az8v4PxgcCHoGK/Jix1KHmF25WC85K0N5V4tSG1P5/5ax8nRIrK3l6StEg5bkjQzJkynLimD6qXX9DD1I0QV4llRE+yvdL9yGicqSqzzmXmfzbvK5s2pmlVkdZWsGDACuPdKM/X//53a65T5kMh0JWW+MrbzFCEg1Oy33aRdlfWu/ZN2yYIxuTYMJOt5fmkFvNzSvJ4IuXRcngpZ2mk1svbwN6FWNZr4DaAEzUi3gFGdhYegRyMXpF3QlXXVmVvzHP2jnDKmurTLZfsS54MMx07iWJIxm39KvN7orFqqBPkgWo5GDLhBVlMmsc/i5nKk8/Nlt5Nkgu0x2ThoP5H9CX7Zme3Ddi0EfLzcjgthnAflfuXy529shqzj57Bq2QXTf37/EiaQxQ8WyUBWKA3Jhn/o3qh4VXfKccXmsq7HqAU2GLayBb3My8LtfwMt24xDOes=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(41300700001)(7696005)(966005)(110136005)(54906003)(316002)(71200400001)(52536014)(38070700005)(4326008)(86362001)(8936002)(8676002)(5660300002)(38100700002)(33656002)(122000001)(186003)(53546011)(55016003)(6506007)(9686003)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JTMfOPIWtVsSUIOHR6T4jsCnlgySObsoqHQFgRRA+jQPtuyR09lKIlMHaeY5?=
 =?us-ascii?Q?AdPagQZ6YDrB4jYoj80GTNeeHmSHPciA7cH1MFA4lKVDw7d2/9EzjPdQMhRV?=
 =?us-ascii?Q?G5lEBOOYpGfBYBk8+LTOVlQVDXDmNk6c91Tlixf2K3z5x2ZwJt/SdwIr26qg?=
 =?us-ascii?Q?8nQYTgNkFwx60SRibq28FG0OAQOvsCfqu1MTqrM4y2/iZYOLrHfyqxPhOVfo?=
 =?us-ascii?Q?lawMNlktlUAfY21lIlognBtIKVLfEApVVDg7yeke4k54DeQc2VQf7W1ThvCj?=
 =?us-ascii?Q?sXeDKXNQuj+ABtWupIpbYRi0/6TR6ylMjBIbzvKxei2/RVpLkI8+TU2/cn4q?=
 =?us-ascii?Q?oCdDh+V6frZFEGhN4NDKpQzGcDyGFq9AFAGy5fE/7g6fndBtvRjk7tHG3FhV?=
 =?us-ascii?Q?Fbq4rrKVIxRDb+nutny1SeF3QYZ55isV+pjTiZgIPJMn02zSMHLhMvdLebyC?=
 =?us-ascii?Q?C3L0mL5TxSh5nsMVVD7uzUZw5siEuotfr/4TDjz3qWkns7IUjdxOrb1/7gnM?=
 =?us-ascii?Q?tX6z7auDu6Ao378mWOVVradvef2Q/zRbUgNUZiTpGeFexY94AkvpyfNFvSs1?=
 =?us-ascii?Q?P2x3QyFZ+Q3La41GbOr7xUd+IsdosWokMK/Gj3M20lhpwNYN/0F05zJNctRN?=
 =?us-ascii?Q?SA4qsHmirGc6I7bUYZ7NHDoY98Yp8641+fePOEQJS01kysmLyF8+g1pkm6RH?=
 =?us-ascii?Q?IIS9177erZ81Dt8IVKvd0+pMtTfzAynN4l6RQiND1+Z7fJc2bcVRoB6difO4?=
 =?us-ascii?Q?qnPLZZoXY20r0TPwg+E7TNhH0DWcRkkl9yFaYC4qo8L0cAsskooBEkESiBwg?=
 =?us-ascii?Q?UUmiIqHY7hLRDr2fquLkp9fWpQ8v5j7A3s4PKhraYhZC5zVQo8zTZi+0nnHU?=
 =?us-ascii?Q?gqzo0kRYPj729YtusfA9vKxkOlnEg/4EFkqto0wMiaxBibj8ipv/01GMDqFV?=
 =?us-ascii?Q?bxoSk+0i1IuqEA8wRHUSZddO+rWg3hi6bDsbMJ0B00F7yKrypDPdwZvh4cww?=
 =?us-ascii?Q?5+SDHfHYsQkmREHI31FE4PQd6DpKsNNknu66zUjiqFcMq7sk8RMRTW6usGQV?=
 =?us-ascii?Q?AjMQjpvrszu4iRXosP2g6pLWhs84OQLN/D38sUzsO0GRPcP/FFT8uLROHtvR?=
 =?us-ascii?Q?YwPzCuZLsJn2xy8suWClPg5fGjX/Elaz+dNmtTkDFa27/4hkiDOvUJmEMXRO?=
 =?us-ascii?Q?WE45zTS9R0XalEhgKj7d5Ezo3m5uV3anKp56e+hMJvEx9bCnx3WPAcvCVNjJ?=
 =?us-ascii?Q?46XredqpHYNJP1rGjE7KmmfseQEpOVcHd0rCQh1b571UBstxSTCtuUyev/wF?=
 =?us-ascii?Q?fVJW6767Alt8duq4jQ44nR4mKL8o2GOY6I61lL9OnenAxNyfK8B4GSmCni7I?=
 =?us-ascii?Q?Bl2pigDQ6nVyk+fFlxpmlUPYwBFtsG2Pwyuwg66gYwfCECTHevUQDcZZSy09?=
 =?us-ascii?Q?HwZFf5wvLxyakW6OdUq40JGuNVVWOutHhgngZQ0Ag+bCCd5KkgDB5fBSajcZ?=
 =?us-ascii?Q?Cx2+MVkZm14XdwKkse/tuw8GI0mnwUC3MY6n1YD0li4Ad+5lnWCh0oHwEg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aa2457-e74a-4ee9-1c30-08db5b7a1bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 10:40:21.1346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl3PRLVpKARRxkBx8WD1ZfwpPFPX66qBha0KZonQB0f2tL8WwmmJzFcPxPn3BiXxszb8QUZXJB4BZBxzcsyDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Dan Carpenter <error27@gmail.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, May 23, 2023 16:00
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Dan Carpenter <error27@=
gmail.com>; kernel test robot <lkp@intel.com>; Zhang, Hawking <Hawking.Zhan=
g@amd.com>
Subject: [PATCH] drm/amdgpu: Fix warnings

Fix warnings reported by kernel test bot/smatch

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c:65 amdgpu_xcp_run_transition()
error: buffer overflow 'xcp_mgr->xcp' 8 <=3D 8

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305231453.I0bXngYn-lkp@intel.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index e9586a0dc335..fcdc0862d258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -65,7 +65,7 @@ static int amdgpu_xcp_run_transition(struct amdgpu_xcp_mg=
r *xcp_mgr, int xcp_id,
 	struct amdgpu_xcp *xcp;
 	int i, ret;
=20
-	if (xcp_id > MAX_XCP || !xcp_mgr->xcp[xcp_id].valid)
+	if (xcp_id >=3D MAX_XCP || !xcp_mgr->xcp[xcp_id].valid)
 		return -EINVAL;
=20
 	xcp =3D &xcp_mgr->xcp[xcp_id];
--=20
2.25.1
