Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A498C48291
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 08:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02D710EBA3;
	Mon,  5 Feb 2024 08:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTX1lU1C";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E1D10EBA3
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 08:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee5Wm9bMR7xALNwWHac/rT7fExMRnnwvkU8yXrVPnmCJTQ/4MVV1Q+Adyt87QuR3s1klM2naQgnUJYB0w4xuTCD4GJoQLGrJHDapUnc0N/zSLd4IKnSmSRFzHUR55Of+9NRZBkO2jz/Srxi/yUWVXF1xYEr5Sozt3viMZpbibUDiHGTD/0YCAlzWknNmyCs2NbQlP/brp9x1Cn1lM72rg8Q+6Vi25DSaMJqESk/iaf3CNtEz+5jpyMz2UL87ZMIL2qgpKMF2kbZ36WN5su/dUx1o7DgXa7MifHj5fWBG7E8RRSlvGtTrvXgCISgWycceWnTYOaPJqtBKHUnOjPZ7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwq00xtUlT6pXawgrUXE/ebish3UJJ/A+hZqNuyWUbQ=;
 b=m6SczGzfgstmKI4ngRbgk/IFZLrg5vLe3JtkPSs+aJjBjFo+AP9FvPUX4DLOIK2nGxZJMbjNlmt/QTb1mNVFHd8d7xxaBKbfUsUDgUBJL2bMjXe5FpXiKnc/iuOdbKB6gpNnaUUS4XvbuXGocCFuQJVm58+Ilv31eZyJhYV8U1z8Ae/xObKSuG+L2h9UvJqX3/pBAhu4rpR1ff9+BH7jNrwUfzl+cmsYE7ZY1VmfwIdf6KIxD5Kf9MKPwgTx+9c1JYQT0eMrT2fvOGg0WnjfyDL+pjZ/97ZktYACErNTZIjbvQv0CIqzWE9N64eLkBOFwER1/cQvYXACxQ7tWCtYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwq00xtUlT6pXawgrUXE/ebish3UJJ/A+hZqNuyWUbQ=;
 b=jTX1lU1C+AR7Khf2EbAK2PKV5Bnc4iMzTgvhQTcEZAfEH4hyWDWrVWRYu8fbDnd9U+5vliRUcG9g5sXNrpWdCWnfnyuK1P283LK1nBC0s9auWWYxqg3Ya9FcDpvEKpLNBA3AzVrb4FkkDLhbiz3DH1sgVaBGPVqMdPDJzC740VU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 08:32:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.015; Mon, 5 Feb 2024
 08:32:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix shared buff copy to user
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix shared buff copy to user
Thread-Index: AQHaWArO6R6TvH4hI0y5vk6CJ9lXWbD7a5vg
Date: Mon, 5 Feb 2024 08:32:48 +0000
Message-ID: <BN9PR12MB52578DB5F943D41352DD3200FC472@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240205080955.1378983-1-Stanley.Yang@amd.com>
In-Reply-To: <20240205080955.1378983-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ddb120b1-51d9-4575-b51c-ca43038d4a1b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-05T08:32:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6338:EE_
x-ms-office365-filtering-correlation-id: b07f31e4-6b40-48fb-4ffa-08dc26250904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GX7jCEWThHPxYBJljt3m1OSaKH2LvcAEWF8IKAglvSkSLjLaaRd9vIjsvaSjvCl4DaGfd6aXVDsEV+ENBFfEFYRU/3N7B5AvU9kwRuWU4eQcdVS4r0G+4jxkDmeCmRPUBSeVh+irFDjEGFHbKuroVFiSpLt4q/geWb/eriXr4iPdLjTewyHl5uTzMYV7UqjEoso+4BqiTfBarrIED8Unf9X2YAh6p3KKRt5UpXqXAKg2AcEgqP9wUs1gI6JV/BI7X6eyI7t8caP0PJXN8zyn/cBDcAhq6A5pBnSQ6fXENoMLPHl8BL2Gz53eHiGtIPcYh/3gE1AT3RhPovUgbXew7dJ1m0C8scx+DgVobSRqoYGx/kuBokDA/zs3ycCO2DZKVlDftMgj89a7HBTbYxsmfcwT6ktykTyewFBtsjp+Ki8/Pqo0XQcbsUcoYQ/goNyxuBFgY3T2qw/ZwSobn1hKULM8YGC+ZuSY+o+Y77Gk83pl4M1TtSy4SrrwuOYFNeBRaIxdpIUlpTlKnBpjzsS+b+U/o9WSbscgD9l5kKbrttPYRiKEoozSG32ul2xkPrhlx6GpG/LJvJL0TEcJgm13UHSnvQHIONJKSNnk4/LqQInLMubrPezsw1JtPGfxRf1h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38070700009)(53546011)(6506007)(9686003)(7696005)(26005)(41300700001)(38100700002)(86362001)(122000001)(83380400001)(478600001)(33656002)(71200400001)(8676002)(8936002)(4326008)(2906002)(55016003)(5660300002)(52536014)(76116006)(66946007)(66446008)(66556008)(66476007)(110136005)(316002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agRgs9m48MZsvcSJvnZtRgs2jN0TmGRUT7P9zv2rWy8d0yYZzgDSCGtS87TP?=
 =?us-ascii?Q?tIRrgvqHJ6uOBekMf73OaPVcZ/t8ci5JH2jwgZY4FdoiiPl4bNTuZR0lPKoP?=
 =?us-ascii?Q?THABgvvt/So2yYMBH25SzkuYx+NhXg1eJ06E348ofw/bezigssyiFwC9FbjF?=
 =?us-ascii?Q?k+NISHfeBfb2qbnBbtluZKzAhPmZGHVlR7dkLPUlaBhfmprf26D6hG1M8eQ6?=
 =?us-ascii?Q?DrilRw0x4yUE/XO5xhpU1WyvgOmJL4ek3n7WqtoeaHCpneZEniR6KMm5RXJu?=
 =?us-ascii?Q?Y4ExNNzHFA9Ncqoq8yytlboc5HSF5z1RkSSHCe2pPC1kv0TGPEXKN3ew/sE9?=
 =?us-ascii?Q?FepXUfXvZazuu/UTphmb2/Ga7ttUAeyO2iTKyP14jGiEteFqDJzKXD0k6ZEn?=
 =?us-ascii?Q?D+fXKEy4atZFUDvDgEeT8+Dq3bAf78HXBYbCsZx3wh1UMO92/K71k8LCCL9j?=
 =?us-ascii?Q?ssYppbNvyg6LI6xD4BLKdefGMthu4zYd3AVOfLXbrjcgw56nhWxQelq9W7tJ?=
 =?us-ascii?Q?gCzrFW63u1s2APnr3SB0ZbgiNi3ltuQUiBVyUPphDexMDUgf3dxzZd3SwIR1?=
 =?us-ascii?Q?AGrhUkMD/OMVs4UNYaSCcBRawt2KM94cZI36FtrlMS4ptqdt4zCyJXr0SXCZ?=
 =?us-ascii?Q?RRWmgXbcjMBjTF+vMLW1XA7cdkeW4GHNfawZ2N6nwRflJiGQ5xKuRNH7ezYJ?=
 =?us-ascii?Q?k0ksOHIfCHGRnP7cZLsxRZFgE9QPDns/OGfeTei+m9Y+CS1sCbWg3SggoftK?=
 =?us-ascii?Q?EGAloZU2sfAKx9bUab+cPJlh5zvvyRBIGVwyQH0t8dQanHNVesXFsf03nIVc?=
 =?us-ascii?Q?sEEmy7iMjX3Z2loEUuS+9YJ9GdHkEQATai0h+lsglzHqtWpjBdq9pApvOLyN?=
 =?us-ascii?Q?6wFPMjz6fwWT0OoVJMJlz0nCnAJx5uEuUpQDN36XFFpr+Z4zBf041zgkTjH9?=
 =?us-ascii?Q?PrUx/SS53O2kKtr7oeFs0x+wixekEoeGlj4smv1MIMQPZs7R8P7Ay0qtV0OV?=
 =?us-ascii?Q?83lLsYOvThbqGQNbmcnOpqYst7LlWH+vbxH3WLKI2909U5zZK6o6kZEFn7bD?=
 =?us-ascii?Q?SqdcuVZzyxXftcDTA7OXwzqaw/5G4hZOqIh95WLwBRiNgbK7Q6bBm1uZ1/PB?=
 =?us-ascii?Q?5aG4iq7HngeYbnkw1Nv9EsTKoJyD2mxVFF2IrmPM3bk5eSSG9PgEC0v5BvRN?=
 =?us-ascii?Q?0Is+xSvDvxMuPcqBNMY36gts4vQOYBQIQSXQ8/xvrs9HYb5BbEh1XmJ3fOBc?=
 =?us-ascii?Q?zf/FrpdfSum74uc0i+mjvR+8mMpJKsnpluRIhVP04UAJosgGHIqfWH7aA+28?=
 =?us-ascii?Q?Cq4TDhpH7tTwYkzOUOct5vkzuzEp3pDuxF0pr0aOtOV6vTc/XNRBBftpjRvu?=
 =?us-ascii?Q?2PxVuupVFYRnKnKk8xfXEsm66m6ce/qsvRF3NXjSJfalsQ16RzUnHT7RaZCj?=
 =?us-ascii?Q?q+K3gBqIfBFmYf3pM9NmvE8/aAIWji4ckwRDLhjOrIpZVLOnfW1KwUpZ2vGd?=
 =?us-ascii?Q?S4Z4CgLNJlrV2PcCigxHJgAFv59upCMn47QOv0TADxB730JHm8tIoUCqz6+/?=
 =?us-ascii?Q?3M69avftzJKXdNaj88k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07f31e4-6b40-48fb-4ffa-08dc26250904
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 08:32:48.6582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCGEV3qUdkjv74R8jBOmZcZBFTbmQuvxA6uxw9HPcddlvv6A7lGF/bhfbyRQrhepbWkxi174w4+41mnNfkMyUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Monday, February 5, 2024 16:10
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix shared buff copy to user

ta if invoke node buffer
|-------- ta type ----------|
|--------  ta id  ----------|
|-------- cmd  id ----------|
|------ shared buf len -----|
|------ shared buffer ------|

ta if invoke node buffer is as above, copy shared buffer data to correct lo=
cation

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4..ca5c86e5f7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -362,7 +362,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size
                }
        }

-       if (copy_to_user((char *)buf, context->mem_context.shared_buf, shar=
ed_buf_len))
+       if (copy_to_user((char *)&buf[copy_pos], context->mem_context.share=
d_buf, shared_buf_len))
                ret =3D -EFAULT;

 err_free_shared_buf:
--
2.25.1

