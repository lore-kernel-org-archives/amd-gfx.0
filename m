Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD7C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8005D610C7
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8005D610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C636E429;
	Tue,  8 Jun 2021 11:27:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E538E6E429
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 11:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BREUzxGur/5BuuFtOEST+DDIyGNLi3MiqAK/bE1TQG3B5TVF+zikTTSDsKnGkPH77sCwhoRtqiXoHXqr6zO2wlmN4xXEhDtGPghSheaOavu/sXHecE1fFdyamocIDCtWnEAwMV9PrhePoANbEYMIDX1b2KykCwwOTaj9hcPBjUaRFEiUr8ryi12fL/7affds/gj2+U51S2aCXBBdoRHpKcdxMoOw1gaHog277qtAZ3rBX9h84juQB5luYtDoK1vNmtGCWAegAe1Se9anwf9WEAWcB5Bh26BXzzAKy0M89+D2qaSeynvHxDqX/095NAcOdT25umDEYDBA/x31DsYTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO1z5QTx8S29pyAIfG4U0fioPuhrpuZiXpTW9FAr1Vo=;
 b=MuIyB/Lw/g8X1v1wTQqJyJY3NrliWuWI3135UeBWFZQ3mxj4Beb5LSvc7Z7ZPylFZkojIuCnURbyOcYgK1ywxyjyjphdPQNYNzfQ3fG0k3tn8X3asMqILINw4VwGNVJRFD6NqAz/g4V5AAdkGfl9184wlpkmZUMqWdezxReZhNlyLTzOLmGtKySscYfsOdNwJ0F3j8bv2I/6iMPmj4QxWDIcR4vpbj9Zewi10M7kAtbu+K/m544L55JUTyCDhGwUWGbs8Pgewe/R36SYO/TClERkjpdmYhOdNtTh5ktSAJN3vybYQj9c8FMDc+Ye21NXKptiBOTrJjE+5MdmOqEKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO1z5QTx8S29pyAIfG4U0fioPuhrpuZiXpTW9FAr1Vo=;
 b=x46ca/8kePCYi5+nKYiBQgrIkjMZh42lN6N4g71VNJ9KbXAagxH635skHvXRmRPqOjQk57k19zzb2caH0Zap6rcVX7SFts6KguB7v9GQZRcT5xJqd4NSc3d0sUGBPr1yGCYBe1+MjdEkQyrd9jIFP67Bc6MgBT6OuFEw6S3Zvk0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 11:27:30 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 11:27:30 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
Date: Tue,  8 Jun 2021 13:27:14 +0200
Message-Id: <20210608112714.50475-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0567.namprd03.prod.outlook.com
 (2603:10b6:408:138::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN9PR03CA0567.namprd03.prod.outlook.com (2603:10b6:408:138::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 11:27:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32e603e-d555-407f-391f-08d92a70671d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5037DC46494ACE6897DD75AC8B379@DM4PR12MB5037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+acKGJRTE/3D/fTcyjG2z+BKWirh1Bg4mw7ZboFe4pgSwMgcNTd10X1aVZhcCkkVE02rCtLXGvFTo9639ubvZUEwYIQIeFnNwZtZOY1x/nazWALpAWaOiEVj/yeJ8DY/e5ng13GgnjPz62iok6PVY90bFSwxKo3Kh3ObF8ASfahzYlPFljWNCqvhd8+NfQ2NCIKzaa/t/fVz2p3WEz77qgEmttsBMkmYv/0YrR9Rbja9QGpn/niuSj9iFJRkaSsICMC15VBaBG8/GQr9JpG6TqWmT8EGb9B18stVm5LXltR4//upV+vnAU9pOpU62oW0+1q/UNuCJVIVVeifXbK1A33ytBjVwD+SLZxnoZ/Va/LASJFrKk036QmdG8T22guQPW2QtX0dy6HNF/0Uhg641GHqJOhef88PecTjtZSqVoDzLrpa3QnJa/NJwLPvxlcQZ0XtGbk+VcSkcH9qOHkvWBLL2+zL+hvP9k90QWjn2Rhf9tZjguVfuevpBIeKmBpo0vbqceBAwukCaHRGNR0T+1PN/F7e72KA9MhvOBuLj7n7//tMrXKSHtWktC/WpmuprBDW1v9gIXDL5rWU2JhOoawG1iqX65RXcmNENuJgATTDsajKbrQyU0cNBVMgXUZXCgskANlKxWMZSK6Tn7VyO6nhfuDM0nBKyiufI+dK4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(956004)(4326008)(478600001)(36756003)(6486002)(16526019)(6916009)(186003)(6666004)(38100700002)(86362001)(38350700002)(2906002)(83380400001)(316002)(8676002)(52116002)(7696005)(26005)(44832011)(5660300002)(2616005)(8936002)(66556008)(66946007)(1076003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUjRdaQ3Qd8nRiGm293dQgralpKdUNuZ5f0q9UvHVgp7f7Vs0CKRZFr3wjVo?=
 =?us-ascii?Q?Gt4A7gK9j+30gWGKEK2m1GwGl7RXP24CfgBIsyBzYPIXctuptBBbUah0kuwa?=
 =?us-ascii?Q?Up50N8XaQisJjQdd2SFdBA/g/C23WARNUjtO25CAyLrG46y1km5nbpr/0rwy?=
 =?us-ascii?Q?UNNP7MrEWKSaS4ywg2TQFBePXdyRGC0tFYB6afD/Z2MyA1THl2TvwJ1Os1kI?=
 =?us-ascii?Q?z8g/I/QiWsfH/McHthGjVj6g75NvOmAQGeLeKnV7G4v9UsSpCngHKukgU57B?=
 =?us-ascii?Q?/S9Kz6yu6+okMibOLuNQZ79CGYsJHtS27eOvYUgrjZYbezt8taUZ5RH20qZI?=
 =?us-ascii?Q?gKAlkm6/MlP3L2q+kGtbAQJNG/L0bWwgHa7T1kWVFNLa3i0rjTQLEk5BoiTB?=
 =?us-ascii?Q?07ITdip85jS0h9b2cF557SwbaTEQ6nxeHU7ca+MSAM5mniANMFeIAnzq8Sru?=
 =?us-ascii?Q?Kpi8uEW3Stn9/BI3N+TM1DGZphuhBC/YxuGQ2rvbEcrOh17gWxUdjtP1/ejo?=
 =?us-ascii?Q?WxM97pU2oLyk3UxYLkNZWKHQ9m6DQq2CN3tDj55ibTP2BRzIicVY31u7avKe?=
 =?us-ascii?Q?wzM+W7tw+Mo4LBQCaNUkSBRdbsoDRVo3ZjCgO0oOBb6s75N1Vme0+edC/LEV?=
 =?us-ascii?Q?1fFXwSJvO13sDkP8deR4Rn2TMjAezF/NqyMct1GCZdh4iH7ZaKqEAMiVcSYz?=
 =?us-ascii?Q?gUWJ+lF/qBtsZjwmQ6+NifZI7JM1q6cYX/Z0D/q8A0fvxGTORopIfm8vWhsA?=
 =?us-ascii?Q?NscEVfdsuKFBZu4a+QrBgAh/PmdUrvQJkzpGTiGHZbe0ihCOEi4234lMHMoz?=
 =?us-ascii?Q?093mWO0hXE8FLQPBUJmAYMw+VOOvvNT7lb98ady/ftRYApfwmCLxG7U4H2Gi?=
 =?us-ascii?Q?gduA7wZ++rkiqpoJiMnMH5pi1dWMDnQcyk+SnIe/Id+Xf3NW9m7DWDmuIrxw?=
 =?us-ascii?Q?T7CGTo8mazwDVjpV7HcHR7k0A9Xh8+GjAWYObQ88hp3HR03pPkvWBKdFBgsv?=
 =?us-ascii?Q?jieXGygPPpfuqDluV1PuiMjywlrzixrQXYRUA9GDKMB7L9Um58scnBBSm7sl?=
 =?us-ascii?Q?JFXq1wdpc7NOQ3S22dDkc1BTsbQcwLSk1Ka8ZEb/rN8f5Qu0eBA1RiOulQXo?=
 =?us-ascii?Q?SM7cQ9do+HiAqQ8yZCLaaGja61PeS+yI3WV0CwERo6aeGU2WzrusazdinutL?=
 =?us-ascii?Q?9Yez1Wx5krBcC45fmh9kuTvXNYu5DJ5SbhOTWJndNYRxdUVkDVtT8oQXs2Zd?=
 =?us-ascii?Q?aEt5i7a30bz+jiREtBqkKOgtxkD/9XRmkykPZ1QyXSIqvVMl8vjXK0xyPo2F?=
 =?us-ascii?Q?oFkc1gWVAgc3tL3l0kf3BIqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32e603e-d555-407f-391f-08d92a70671d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:27:30.6339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnj61+biyA/L84XxW3QLcuj76BsyyzGwLSOdgkIDCbI2kr5e3OtI3RA2QWg7B9oLjZPHzJsZO/WAm6SnT5Zr5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes handling when page tables are in system memory.

v2: remove unwanted variable.
    change amdgpu_amdkfd_validate instead of amdgpu_amdkfd_bo_validate.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d6cb7cf76623..021f25085760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -348,11 +348,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 	return ret;
 }

-static int amdgpu_amdkfd_validate(void *param, struct amdgpu_bo *bo)
+static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
 {
-	struct amdgpu_vm_parser *p = param;
-
-	return amdgpu_amdkfd_bo_validate(bo, p->domain, p->wait);
+	return amdgpu_amdkfd_bo_validate(bo, bo->allowed_domains, false);
 }

 /* vm_validate_pt_pd_bos - Validate page table and directory BOs
@@ -366,20 +364,15 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 {
 	struct amdgpu_bo *pd = vm->root.base.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
-	struct amdgpu_vm_parser param;
 	int ret;

-	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	param.wait = false;
-
-	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
-					&param);
+	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
 	if (ret) {
 		pr_err("failed to validate PT BOs\n");
 		return ret;
 	}

-	ret = amdgpu_amdkfd_validate(&param, pd);
+	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
 	if (ret) {
 		pr_err("failed to validate PD\n");
 		return ret;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
