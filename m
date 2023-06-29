Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB1EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 10:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805E910E0E2;
	Thu, 29 Jun 2023 10:23:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FDB10E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 10:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcKufsGExWlfzd+sn4NyDZyCB6uPSXJKKI1c/Ea25r9Cpxra9muIGKuqZGixQKVfK9JSVyk4t5aWbCdrLbpiar+8t8rxKjvhh4lFj4H0dBSMajQf42a0FqjsC/13Q0dKULnlW67DKSNKBiQbCaltx8U60DoLiFlDJumactJn83GrBQ1R5K11S8nVEjEibnflECennZPJwF/hvRBbet15iFptIkATmj9nZFLN1GKLIEjmZaXN8eCZArNlWYZN+r78ejVWTdb8Mnb5rN9JgxuM1Jy8Jezm/6VWX352yeizyFz2SuqISXnYSMpp0SDC1pO6rvjPvIFZNyBMXOB3S8Co+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCe/g9RGjqqjlfqkMTGjdlBx/fVRNYZovifXmW5cQvU=;
 b=QT+O66DOeybuWeTDaRoKnWEq6Oq3lqOrKAEk/4mCz6mJCHjQ0qG0NTInmHSpvGOG3dndpbTk/jS3e82pQTn//dLLaOH5W30pCvtzDI3h/bm5dD5PTcdFUZYnfcbjvWGa2qiWNnfH9KgSpC4hjNyqz6HIrmJNJsfRcAihMzqcLmyUztS+0oVfm4GDthIPgC8+JhGh8kbBqpLzeF25fagvS/oLAct8spfZB0Sn2RKZKTUjGQe/RhJTnrXueM7P4ZmUrgePqazdBpWx2YiIqTunu/0uLKZcXKKKxf3Ms0gvSTOIszzWR+gtkwHbGxroDAWsla1cPB2G4Js/8901ds4ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCe/g9RGjqqjlfqkMTGjdlBx/fVRNYZovifXmW5cQvU=;
 b=OpfoX2o7fKwIkWMW4U5qmI5FAuhVNOVEBg/e3f6nvUyrQVauBtMhJ47Gz6X7zkqZegMXijovwBS21ZRfkhTb9smlYmQSxdTUsNTyokJbLIiQG26DfXaNF0HTRPFzfdHQZKzGmvoydMUh3woCkUz7M9s1zfS9T9e5QxfRgzAMXB0=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 10:22:58 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::d73f:60c0:275e:b3d3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::d73f:60c0:275e:b3d3%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 10:22:58 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip address adjustment for GFX RAS injection
Thread-Topic: [PATCH] drm/amdgpu: skip address adjustment for GFX RAS injection
Thread-Index: AQHZqnCp95xjIPSb6UGyEnt+ka9s5a+hkQsg
Date: Thu, 29 Jun 2023 10:22:58 +0000
Message-ID: <MW4PR12MB6875264F2A3FFDB7AF0739ED9125A@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20230629100056.7516-1-tao.zhou1@amd.com>
In-Reply-To: <20230629100056.7516-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a7743b32-b7f6-45fa-8105-ee539471c945;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-29T10:17:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|CH3PR12MB7548:EE_
x-ms-office365-filtering-correlation-id: 5b7f4722-f146-4c42-4bd8-08db788acf52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bkz+VGrMRfB28Z1sa6pIxxpNclKnFMVTIRQLJv6NFI/oJvFB/2LiFnpaqc8uxgYTxNAfkcz4ZI5jWbrILgHH3zWPxuhgxGfVfo4GSfW0HJFQNGxKENLvg54UicfsXH0g0WwcfkzwJKESCzDtGB2G5DYgqLkNI0RCkcpBlV0neR4fB0A5KXkLF/PwQeed6ddgMXPaGeHEgVS2nJA8CyjtMAG3Sl/iAXJQrHqyGSBRSdxvv4Ta0RwK3S0JxDkuoeIw6m8GhK4ijop8ZFsSTfpQtyGJ6bkHcn0pRNvopNYzIy7z8blPghgqAVPnLi6pnMsvkUWKVhjwghWBkkqT2Tpwj4EwpXg2r0owBlTUUemhRqh5js5jIHhsrn1LrSEqeyAdMFynN1JTq5rdvxFG5cC+/zkG3yHp5+cUeuHz6GBcJ20bbOg7WNBWKSikfO7I6H4Rb6LSTN5z0QHjIgi/dKJ37n4r47t8gx4Lkz6Ne9H89lJ/bKiy8/8rLREPQQEQtdogCc5Q1hpCRilLvYwyNun9NawnQkklt8O6HHYQ0/R8dRLbxt9xU9OtbiezjX7nisjflXEkMhpF3xMso65YaXYbPnFrWMPTYhAhp1T5J/Q9poWJiuHX5nMDwtv0n1LUyEK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(66446008)(7696005)(110136005)(71200400001)(83380400001)(9686003)(2906002)(26005)(186003)(478600001)(6506007)(5660300002)(64756008)(33656002)(52536014)(38070700005)(4326008)(316002)(76116006)(55016003)(66946007)(38100700002)(6636002)(8936002)(8676002)(66556008)(66476007)(86362001)(41300700001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+V6fMWypIOC9S3q3DXDmViWiAZN34IwbaLVagkGDnmmrDH8rthcgTfhoH8YJ?=
 =?us-ascii?Q?+UNtZ01T5pMxwh1OUPItxjN8KK0kp4kHLsDp0MmOCIwiSbiAFsbpdDAmntjM?=
 =?us-ascii?Q?P0nz0MidBsXY3wjeu3zkwv7LKJqCZO5o0/2m/2kWGlUJOyrjM+x9FoiBS07s?=
 =?us-ascii?Q?tAD0yYy0aN9pSvo6K4nwYYjsrH7MgsbfmFYpYBfZig6ExPSSUmMmo0o7owJ0?=
 =?us-ascii?Q?vYt5vvr1WKhO/mtTdQTdYA6d4GvulHuGC45lbmvGMY30hPdAs8WENRadD8mr?=
 =?us-ascii?Q?MfRwjrMKYQXNN6q7c2tjCuu6i4/Ha5iaohP2+jm14u5YMev6t7dDqkJK7g5E?=
 =?us-ascii?Q?NfdZ40q3XJmfOgTkdSGqwydzal+h7FIwL0fIt3zpJcg9wWmyT7zi6vTG3CG0?=
 =?us-ascii?Q?UtLZOcQb8MeUCUsOEeAtll/AOSUPdKxSINeC95c8gDPBFT1RkL9XnUfyDoqc?=
 =?us-ascii?Q?JUGvg1NkvcZWnkXTxAqIDh2/BfYgkC1J8kibxbvke9lRdjQCtfOO4c0mxsxq?=
 =?us-ascii?Q?6haz6wELaSBFx0LORZXkBAO4VaIbDol91r3P23JgOTJpfcSjpPnIAfCY6IYp?=
 =?us-ascii?Q?kKTSax3Siq9UbREuYLilI6JLZNdKjA16ivUKEcnS0iBM3u8tMnE+mugtrHxa?=
 =?us-ascii?Q?i1XSetLE2xXx9gchO8CefmAjslnK2D8if8qV43I3J5QDm5T1kTXg3iANQyTx?=
 =?us-ascii?Q?/updUO1UewAxDvyps12uQSyTIhI5cTOi7VQ7dSj5KZmueazMvX3xoMYDGf7q?=
 =?us-ascii?Q?efHQMDxSuKec7wCA3jxgxOD76zaMyqGivMxWpEIrDlluuYMtKcWcDj+xUpy0?=
 =?us-ascii?Q?b09aDIQC2xu3Ai0kI84V12urMucz84xMdNly4xwN2ZjG3YJ5AYccRcYXAbrH?=
 =?us-ascii?Q?cM8/U9wkP71Yi3ZhR7aIrPBt+kmKF3BP09kjdiJtBqBZwgV/Bqw7xeiH+X7A?=
 =?us-ascii?Q?Bt3+26kevEqg/DAeYic7Z14ukYeHzdxdgfPu5e/Ep5TRpUc9stWjW0lnesKf?=
 =?us-ascii?Q?OuajpJCxc8K8+68NpzVRqs1brGLEZ3eTFlpV2Rd679e5yDKcMj9ff28RR44T?=
 =?us-ascii?Q?iRGzHxNAGc+nSmaoerTMYQJPHin9YvPe9LNK1lfWEaz07dNijLUBn92vR+Jh?=
 =?us-ascii?Q?33s647LLHrSum4/akAHbKjYn0XUiRXeBtR/roQQ52lC1aUiMbU3MiPAx1Tuv?=
 =?us-ascii?Q?HWkOAqjSRpPD3pQZs9H4Flruwb0wMokO1GpaTsReT4Ux8vInypVsNOmp2Yel?=
 =?us-ascii?Q?Ftql/U+sJLDIIsmFbwkdB/OLHIo2wm4hRDS6o2unfVj9SYSoeBSpmSzUd7Fp?=
 =?us-ascii?Q?T+YYkhTd6N0TPHhEqT+V2jN1kA2D/EtCoex0VdlxKzCuaNHFN6aXDWrtpG5d?=
 =?us-ascii?Q?DGjteR47MbfOEywxZCkcv2pQ26RJFnEbXlvRQLvZFsRNGR4TdXvohlpiSu9L?=
 =?us-ascii?Q?K0Ptm4mIn8Zz8Ux83iDajHlCY5UJm5w4rHRTNDD4FkKXOAvKNyaz543c3lFY?=
 =?us-ascii?Q?BsjjENxNTaElzTWXRETL5eD0y5yZE+SM9msvm2quGHmWIgkw4cFrVu/8b80x?=
 =?us-ascii?Q?gicOmCy2F+5Jim+wb2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f4722-f146-4c42-4bd8-08db788acf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 10:22:58.1675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awcjy6ewBRUOl090wgFSli3ARz+rSWl6XFHiKKO30nKml13fXJh5ggFlz3MeyGWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, June 29, 2023 6:01 PM
To: amd-gfx@lists.freedesktop.org; Li, Candice <Candice.Li@amd.com>; Zhang,=
 Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: skip address adjustment for GFX RAS injection

The address parameter of GFX RAS injection isn't related to XGMI node
number, keep it unchanged.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 046659bd4f9e..5371fbd3fe17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1163,7 +1163,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *ade=
v,
        }

        /* Calculate XGMI relative offset */
-       if (adev->gmc.xgmi.num_physical_nodes > 1) {
+       if (adev->gmc.xgmi.num_physical_nodes > 1 &&
+           info->head.block !=3D AMDGPU_RAS_BLOCK__GFX) {
                block_info.address =3D
                        amdgpu_xgmi_get_relative_phy_addr(adev,
                                                          block_info.addres=
s);
--
2.35.1

