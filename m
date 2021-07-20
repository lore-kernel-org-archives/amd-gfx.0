Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93605C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6428D601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6428D601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5636E44B;
	Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CAF6E43A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwlqOLyNf1Q6zPBL+e8JZkl/xjkcqHreolv+OmpUz2iQgZHqroVEOAxeY3A98M2vVhttQ/X9lsMbh0/TexcJChqHKgGZcI/f0MD4InQeD9TszxVbTT8IZzRaFe5TUh+x/nFbyUSE15qguO6ms1FU3WG67w99ztxSEUsi3JEoo03ZL5cO50+rL4U3x3/+wFCPMroYJRbeXzzHS3y3xH4GRXm1yH/oGgkiYWE5swhdTezQBWgtRmOHT8Q8crs3tXlhKrBnjPbmcMNQnv38C7rTTJwQR3nJU2YX0AuxscfOQS95dZU0NVxXYN/53x7a2ueM0qwAsGcogwpT6aZNtz24fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3t+J+hlqwi3ByB7QpTOXOlWg9/EUlmnUKbEClhZ+tc=;
 b=oUo+6hrx3vqt7LKavdRwtmSFruEmsFCZ0dbudHxMVif1lW4ng7nWh0Swq0o+93GD9ZjLsHKS4CVKZBWh8GY/edVMQsCD/tBD+DWVjY3kXGVZShkq5LmaIBKZtcBdYmCDGYHTUvtpkCZjE4P7b/yIz6gQmKLTrszxkCaIEi+u1OLceOqE8RZAiw1MoFr9qq3UZDVzGBsmGUdZOVrNQFsRBzZX9KNIQcZ46ZGF6Cmnbv1x8ecK7TEhzGZS4+/6miZQIGxO8ljH3UtX8JnjJj7xGGJJ1IzQyMKilhFQcBPH9LK8N6hYui0U4uaBAqWMJXIcelt+YK6OO532n8WZzDyYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3t+J+hlqwi3ByB7QpTOXOlWg9/EUlmnUKbEClhZ+tc=;
 b=fIGEfFYTVQ5AZsUqq6ORY+a4PXP4EjLomyskIxJz7eecqK3UMJnOt2MxAkYGIDFqytlbiP0+JMAMWsRMdqzngfX8O1suoDn8KO/Mz0Ebhaw8U6jPBizIx3uv4FZp07nERDFDVENCK+D6HLLxbQxroODboxi0MFW/t8sXA0GAfL0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/29] drm/amdgpu: enable psp v11.0.8 for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:40 -0400
Message-Id: <20210720154349.1599827-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 968cd8fa-5a2e-4569-bb33-08d94b953e6c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349E4E4B3588C67A30DC1A8F7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkVWgJ5VcejTWNKC/N269Jp0VXPo/DvJlez5nOgFWnFFbuYzrIl7K2Bixe8Eo3VKX5HbSQhH2u3qAQW+k5jGrMiElE0AaYj4SvbED1x5cRpWu4f9D0V2bKlk16ECYxwhu9kVDVSjSnjjFz7BqI8z/YxTwoS21RgEMsOqvTAbDrC3hgOeQDzQmOPJNVCJnedDcVIWUfJGGNGekbhV+9ihmQMQ2ME58u4oPa/W9HRl12xqJuuMYrc7qKtf68tWytDTQac7fuCgNM8mF4h3sgD7JzuVEXXN10ArHRKnE9lshSfDsOM8AWTFiML00tKb2BQtsgKfQ5zspfyvWj0LxIlwCOITCILpGWs03orTOIMhut3exVfFxV8cocdIyaEqnw61sXcswm4x2QP2Xg4KIl+2VcqGw4J3e33qJv+TCh+7xcMNsPRtNvyrCLopLFptEqt0P5PWLvkGYR709TS1NJip9OIly6X61OJ3uH7H29PmtaTd5ErHH1m9RmUs3BhVCR38fUSwrS6jvHMUrJWnPj6cVXs9BXcI1HTAdoEys8VgjWpuhOlCIVW68ZuOKjr6s/RcCEldFkd21dE2SJFuqirVIFtL8+Nm6UTal/M0m8ohvAtI+o3TVtvz5mwxhW7IdDOd2iMXjRLTL+0DKTsmf11Yc+6iuOiaMIakRS+Cb1CCjm7CDE7h034yo9VX75N3P/qznG6+ct07HpOKn2NIoV6LNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHsUEdh4spiExuPgWmH4xi3habksJTb7IysfysY4oEEXmYTC8DqggCgB8G+x?=
 =?us-ascii?Q?JQmcePnZzbLesWUA0hkuMnDqN9D5+iAldPJJV9m31UVzxWIiECSj8bWf+c3q?=
 =?us-ascii?Q?YYB14oqlcYh0XLN0YhBCnmGthtGFmahfaGXtuY0nmBDKvh5i0LivyxBReEPP?=
 =?us-ascii?Q?tHoKQph+ZaSsS/dMvc45Uc+dKrHdI2pmH+PyfEiAygpcZhmxVkSA0vO/1Zg3?=
 =?us-ascii?Q?GYaAvjaa04apEbCYkCXRfWE7Mo+bj8D/w7oMQc8QwTqdF3HmAhLVhbgOYptp?=
 =?us-ascii?Q?EzuI1fof9v8+P1xJu/K04lXUpGdS3Q3M4QZhcYwe12zKZjkkl5a4RFJNxTj4?=
 =?us-ascii?Q?of65r+2DPURztuyHWggPzuTwPhFh+2KGPGoMUZzDbAH9vCBGeDmAerk/DVHn?=
 =?us-ascii?Q?j4H261f2mFRDbf9NTNMFZPMQqXih5GcAaCmuFtUeIhoA/vl4THUk14zzCuQQ?=
 =?us-ascii?Q?kFnozluPuQz1duC6dGW6Su1F69nsEdwIM/U0GSa3LPb15SUiZldsear6bhRO?=
 =?us-ascii?Q?RomOiSIdtmv0NalLWihtso4ktCOEEDkx+PR639CXcYMeNX6z2bTc7Tk5Suqx?=
 =?us-ascii?Q?wXhG7YNAWXpirItNV9Lhu4j4liumY6dhcTwUQnJuZKlUN4KL42UsA6SPWDqI?=
 =?us-ascii?Q?nW7zUiE7QCyC+j7kdF7mYqVaRUEDv1jC9B7+N8iZrXq2WUPj834Anzj6y3Xb?=
 =?us-ascii?Q?R6+BrCYfTDXePSMLp6Wqe2xNrR+qtk9qdPT8pHlAEFJ6D/VT4/4FIMSY9mFv?=
 =?us-ascii?Q?akBNRZ2UrDepiWHTDXoCRt88sTw0Vd0ygQGDDrH4oeHb+UtQdiKzqqMPocCA?=
 =?us-ascii?Q?QtK1p4SbVJgxBOclJ6eEes6MJRAR+PW0QOts4+PKPm4J5jRglLAmSELKABhb?=
 =?us-ascii?Q?wFfNCmXUlIi8jJykDKajQmIWUj6fhXvbQBAt/i49MTDqs3DZ3E7xiRNzXu+3?=
 =?us-ascii?Q?6uma6MFlidhwJAH72bQJ3CkrThKsPNnOgJo+3N2QuXrCRDeacYUAGGSVg5//?=
 =?us-ascii?Q?dHvlEeyCnyJLU9x9X1yvvtyVyZR+8ioTHR1Z58xvI9bvw1IdvPuIvlpxKkOf?=
 =?us-ascii?Q?EtkpIMgi0m9LMCMDOb/2JpA+pRiUPMOHmkk64FZJbFrVNCFy75rQqxUae/AE?=
 =?us-ascii?Q?F3EKXysxB/CA4ThLGMDyU7vXlq3F3z1d3W+JCGN6dWMwAD7TPOuaIKtJ0rA6?=
 =?us-ascii?Q?rTmJj/uWJG8rv4y/Nl7Pedg9VVrv99IX9mzlFzwvAD0mkz837SkYI+74TRDr?=
 =?us-ascii?Q?8nBW8Ff+7Lwj25gJYXagcEwsFl2rxfDugpNGa/kJ1kULLBK2+Apw2sLSAPpR?=
 =?us-ascii?Q?B38nIjrY2LIj/NiR9X76F+pT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968cd8fa-5a2e-4569-bb33-08d94b953e6c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:22.1459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpbW37+JW8pL8yEgCHAGfeyUEud/U2Q3bb5uxh1iFG/aShHEvukonwVXsX2QXzZpHe7aay6Dvivd8jOvre6/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Add psp v11.0.8 to ip block initialization.

v2: use APU flags (Alex)

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c         | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 821a521eae38..644cf7b1106f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3398,6 +3398,14 @@ const struct amdgpu_ip_block_version psp_v11_0_ip_block =
 	.funcs = &psp_ip_funcs,
 };
 
+const struct amdgpu_ip_block_version psp_v11_0_8_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 11,
+	.minor = 0,
+	.rev = 8,
+	.funcs = &psp_ip_funcs,
+};
+
 const struct amdgpu_ip_block_version psp_v12_0_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e5dcc6713861..98c0ad196eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -427,6 +427,7 @@ extern const struct amd_ip_funcs psp_ip_funcs;
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
 extern const struct amdgpu_ip_block_version psp_v10_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v11_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v11_0_8_ip_block;
 extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c79b8b5311ef..894b55d1e10a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1050,6 +1050,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+			if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+				amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
+		}
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
