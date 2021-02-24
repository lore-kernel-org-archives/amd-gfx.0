Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96579C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0D464ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0D464ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23046EB57;
	Wed, 24 Feb 2021 22:21:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55B6EB52
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXceVBkwFa4N5a8skmte54j+55cBX1XZXtE6lB4r4CttjeEfeQKdmFMXwsyBgL2oF5wkSHFVaQYLpPYMSwVpimonyrANJSZLyDCbVcbjhfKipi9OmWN6xKwIHzP1fnaaLBQAhtKKE3K/CQIN/dPtqJ6RBrufyXL8u+tTDyoBHcEy9gmUwzj2FZNCdvagvra3GNWhZ6Bw56M6AvHI4B3tQ0nHbPg2lFBMP2QUEnn6yCanTmqeL9T5BDrIjUorejCfGpTe/PpxeE7JdSoHUMPUiifN3oewfqqy16fV17boMh2cEzwzVN1Y8WtxjN0nHQhEE14Nwrmf/sSDjOhIhon2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix9iZdpxHI+YPqXKS+lgvAXsbxxJH8lYquyvWEL5FNQ=;
 b=i/AOgzk2YijAMjjd/gQ0eiomzZF01a1NQjOAGfalzKdrER8bIMhYpjjiFDUcmh3qa7uw0c6Yko9KkPATSN4Yv1l/PRbvajP5/DMVQyo63iyfgLlmwLv7mChcSf5rPfNznpUospIE/3bDrXFWZTnE3g25cG7NwbLg2LEy8CQRjj4cU57xBwgYQtukA2MtanNwo/Go3HekH1tlqGpeJdDk+F/H7JQPYru7x8WYE16McASfpTll5q7Hfw4L/MHy0LitXT6+Pis0wzwFEH3GR1fLkQNAUiiTU3VmpXikcLV7X+JCYXgG11ym1RNZ37+62sf3E0spHBVj8albRoWqM9LVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix9iZdpxHI+YPqXKS+lgvAXsbxxJH8lYquyvWEL5FNQ=;
 b=DLQSklp5eD2itSqBGqgo+GRzXew/KB+Rd6Y3cTHSYm498Qcerxpn936WX6pyBW3LAM5pLplMAlIAnK2ScsAGMytlnjQFKrm1DMJgYy9b2rV6G8+WtaMSwPYCWY73vGTulEQuQDLYFWjddJNRdvlWt9Xx3YGQbPgBLOxNlz3AaBE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:01 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 070/159] drm/amdgpu: support get_vram_info atomfirmware i/f
 for aldebaran
Date: Wed, 24 Feb 2021 17:17:30 -0500
Message-Id: <20210224221859.3068810-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5cb71f70-131e-42ab-1a2c-08d8d9125802
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497CC082461E5312F6F2FEDF79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuKgGid2xM9K+Gv13pCOoTQFkX1lC9Q1GVG5YfXHE+ASp/jQNx9OtItNYduJv6GaCTelSzpesoM0zKCVD0PKz6HwY0GsDnpr2MSljCU2vfgMAZa17m+5QV5WDkUIElc3QKVi8XmWzQvBnClnAeesg1beaI0j4pukt+E0ed45z4wYGPHMCI2g5j4Cju51vxEPPJ7cQWUiC86U6zBgs9aSXpEDHM6ISvuf9whJV+gF24TMahkYQSHFrre6s7QWLHSFM1gINbei/PDQUoEcWpEngUo9bMvHN+fG/gPdBpG43Ab0vPM3MsrENXEYunaGxlGgNP5X4bRj2PikBwHC1xX2ohPN0YlVe5Z/iLLcpHKssUU3NKa/az3B7y5s8d8OtUQ49op5/B4DmtvGoc3JrMP+p07CqkrwXRUU6WV6t5x8acjbWbgnoctXaGot0I78ECFr/nnWEpA4dncDDZqgg1RpjcbqHkuR0GM/Jfm7FCUbd7lQENd6KZoOpUiUqkLu2hC+wvaXq0827zYxS8oJiSqseujCkFfzN6IEx0P8fS9rURnEoDbbW7c22VBtZaG2dmzmxmiWA9JvcQxqPrNuiiVTGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V9j/beJ6fT2BbVvtr0AKKbb+D6Wu4HmVZO7LTiV7O87zUQDAt6YkB+dyeL3i?=
 =?us-ascii?Q?fXqxsc91PWl5q9LT3t8judWBAF5AbbSIs1BMQHy1k7qL0VTmxkBjWvQKpV0r?=
 =?us-ascii?Q?0nhCrm6TPxWizlRK/SuqHFjXQDDgJyNyVzG4zcGJvG4gPGtsLj8fUs5iJJYI?=
 =?us-ascii?Q?yr4P3v0vqWSAfzndYYIVBTq0KSvP7+OTCXXcB5UkYKflcMEiMKOWl5ki/8iN?=
 =?us-ascii?Q?KyLH3vywD39lA4qpCgdZ3vZvKDlkby4k3321IJ4Y9uPu+AwTcnaBefQlxRiw?=
 =?us-ascii?Q?rXXZ1jjL0Y7nv/R37SgrEURot+ClQSfUbZnhyuE15TJ/3NLB0DsF1hC4Aqwb?=
 =?us-ascii?Q?UrOEEVDFqKkdUn6VLNRTuF3qOXJ7eVbVNTGi8zFzncG9bi8j2DeYj067vqUC?=
 =?us-ascii?Q?uLsIZgQxI/kFuIwu+8Que2thKsSVIGpiWgNV+ul3P6KZUISKuuKJaAEE7Y6j?=
 =?us-ascii?Q?J/wjIkGPXoTN9PF1Rj6etl2tBATj7Suaflfm+elWTxJ/EC5oDg4DWxjzyd/k?=
 =?us-ascii?Q?+0WAOxBSI1GfDqIZW+tRtxDegLi79mOm7Nn7RYbiok7OhruWIuzZrTpmVK9y?=
 =?us-ascii?Q?xL+FXESLQiwRALNrpC432WWyy5kCdjcxVrffxoVacYqfB02QbIhOJSRNxe/p?=
 =?us-ascii?Q?MgJlKZYsxL/u+zdIM+uPzcYyS50vzn+bnfF84RgAA5C7vN/JIvVMkDE9AbB/?=
 =?us-ascii?Q?SqIvqWKH5pbEXuGDUhCKmhhZi8ZgI3rzbhiCXc6K3CFueKzUsVLrRzKmlMZ3?=
 =?us-ascii?Q?a6RhRxjjCCvamgxLh2WUJGASo6J7n3ezhtO4/em2CGaFJ9DXgYZAgWqdztcf?=
 =?us-ascii?Q?aZ71WAtXEalvPNFh1/+PlB1XQhFXok9+c3zYRAxYj3eqQpFsjos4Pfiplioy?=
 =?us-ascii?Q?eJUlo9hH1GkBxXqBItmqV63HcbZHUu2gj3LXCIGIdYnWr2ibrceeIxCPSmXb?=
 =?us-ascii?Q?DwHa1uk8iXzXNeVybkSSysm3ymvoym2AEqLlkZkl3njfLNxXffbWGmwd3lAB?=
 =?us-ascii?Q?0z2XD79p98WMHJ4QrN1inuIORQ+/ccz3C7OJHYln4xrZGKTnX1ausA8KoWoa?=
 =?us-ascii?Q?79JakFF36saC86UfgbILaWV8/QLjFm9heebFKRAh6V+84MKdlv3+eySPjo4h?=
 =?us-ascii?Q?Dbd6C7gamPAoZ6gNoPtEpxbylKBNUCKFgcxXyzJfeizfKBh5nzApOCEAn6VX?=
 =?us-ascii?Q?TfS9DcrfndfPYOn7vpiLvOj2aEDBnJ8er+fXrFe+NyQYkAAyuqKhZXYr4bTR?=
 =?us-ascii?Q?gk4Jv0XaYdsqJsxtdBaQBSYi+4WuhNkJLTgSEgTn+VfSXuObUUbg6vmqCMy9?=
 =?us-ascii?Q?PN3ymUqzatxTpHsTnYVtm1w7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb71f70-131e-42ab-1a2c-08d8d9125802
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:08.4635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACTc5gGQzqMLyuHJ+517WU7COOZyHR+f9RMttfTG0x+/orIlKQVeimKXJgNUF3hsTLYxG8V2MLBs9qumeyqbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Query vram_type, channel_num, channel_width
information through atomfirmware i/f

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 16 ++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6107ac91db25..266d949759fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -123,6 +123,7 @@ union vram_info {
 	struct atom_vram_info_header_v2_3 v23;
 	struct atom_vram_info_header_v2_4 v24;
 	struct atom_vram_info_header_v2_5 v25;
+	struct atom_vram_info_header_v2_5 v26;
 };
 
 union vram_module {
@@ -315,6 +316,26 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				if (vram_vendor)
 					*vram_vendor = mem_vendor;
 				break;
+			case 6:
+				if (module_id > vram_info->v26.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v26.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v11.vram_module_size);
+					i++;
+				}
+				mem_type = vram_module->v9.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v9.channel_num;
+				mem_channel_width = vram_module->v9.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				break;
 			default:
 				return -EINVAL;
 			}
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3cb8d4c5c1a3..ec43a4fb761a 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2789,6 +2789,22 @@ struct atom_vram_info_header_v2_5 {
 	struct   atom_vram_module_v11  vram_module[16];        // just for allocation, real number of blocks is in ucNumOfVRAMModule;
 };
 
+struct atom_vram_info_header_v2_6 {
+	struct atom_common_table_header table_header;
+	uint16_t mem_adjust_tbloffset;
+	uint16_t mem_clk_patch_tbloffset;
+	uint16_t mc_adjust_pertile_tbloffset;
+	uint16_t mc_phyinit_tbloffset;
+	uint16_t dram_data_remap_tbloffset;
+	uint16_t tmrs_seq_offset;
+	uint16_t post_ucode_init_offset;
+	uint16_t vram_rsd2;
+	uint8_t  vram_module_num;
+	uint8_t  umcip_min_ver;
+	uint8_t  umcip_max_ver;
+	uint8_t  mc_phy_tile_num;
+	struct atom_vram_module_v9 vram_module[16];
+};
 /* 
   ***************************************************************************
     Data Table voltageobject_info  structure
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
