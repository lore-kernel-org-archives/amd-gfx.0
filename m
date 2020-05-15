Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125DEC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB06420657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hlmyWy7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB06420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6A46ED26;
	Fri, 15 May 2020 18:13:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4EA6ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvHsgnyr0CJ52RIi8OvrOszDSx6+ecf+5AMpcOOIfK6oLu66bjYsYo7F7I+Cf74j9hxvBLl1VXxbhcJqlnQLvQNGviV40V0aqBYADTv+t766NXXR5TF+BlU48LW76NlbJQb0se2/NgInsC7TafKpJaMyGHaNZM6TVU7Yd/HtJQa8KW+5JWMuCZKvk1kBHtQlMfDaaCeAj3FCkXv6hp7UseHhgS5cFrL4jOgJSiSVXNZyqCIgGIot7FRzrto+h2e1U2ccPlURMk1i7R3C9zTG8oHBsNxa0oXWsHpUfxZTc1IkiPvMi4LatjgP6SEjmcA9Y9Avvz9ZYO4Puj8oi3iliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yKE4KdGa++Jg8JXeSWXVD8ua3OmdJA1DPNTRJVBCDM=;
 b=j/GJKVlXWoMEudtE6SgIgpgr+wdNclpDp7LvXZ615lTT2gIXWzG9KVRvjkBychJzMzuvy/8cSdjbX9F6PC8aG1yW3T+vmyA6uDUgClIdvao9qdCJHBDcEa7HK48SnMymFcqPW2nt5GhDxjbHT2v27sIb2riXv9ytOfvOZoXcC8EWHHWJllgVkn/QHSGUpnUgsiA5HNVNLRsRy/Pt6OgT+5aMhudZTsa/25maFKN4dRshN//LwTUbX6H86E/qrqqfOIDPRpux2deRRXooH8HWCx5bRsC7Ir1TiIG8GG3xspmJ408LB5/TYMDKGPmDuZrmWc5V+bFiRpIevAn8wAacBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yKE4KdGa++Jg8JXeSWXVD8ua3OmdJA1DPNTRJVBCDM=;
 b=hlmyWy7i2IjV7ri0x3gW2NjFE+5gG3YQ2LYZodT1QvlE64QQHocW0ucJxSPqwk6sUTUwlAhyZ/hQISxUS+2lz4gumj69NtM1Em56NmJKpe8l5fX6ins9eSLhft28/O58DPFiQ9mTCD/zgKXKmSPrsdcFI3Cl2CjeAUc7IArpNrU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:54 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/27] drm/amd/display: vbios data table packing
Date: Fri, 15 May 2020 14:13:03 -0400
Message-Id: <20200515181315.1237251-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:52 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65c794e5-99a9-407b-6dfe-08d7f8fbb9f3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848A7E7158CBA7766C34DB098BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6STGWNso9/2KJTSDwTR/TxfSmPzJxRY9GW66N7GiWeEtBP509IpW+u7Bl3mVk36OyhorTuMQ4w8MSX3PxqB9yHloa5sf36Tbk4Ns7yeKrpKK7abTb39FDVa/V/tOG1IZvd87+f/8i4Z8AqToUj8qBvCFl+esHC37kZfFrW4UGXu79A9cyr9NnSw7Dp/cjG6HhhqEXCkEL6bv1AaLCiIEaYkdLuZLY1GgTh6Z3GkA47+NWOJrpfIG5tFD/GzUZ4H4m35e3CZOm00OtpFlD/faTp/MOHwtLy/Jjy/GVtkY147cafIy8Y9EIlGc8ULvF81GjlkJT8oxrhrfcIM+Nw3YoeYtosJ9GgPd8m6ksomLGDleKN5cfDRWUaOZ8wfX5bU8RRbCVtLwLHd8vjePiExR16/KnKX1UV28aUPRR97c0IHxTVOOp/Dt/IRbitPz84Z6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ooG3oZ8ptrjSgEhgI5tSvb68N2834/SUxYxxi2yv1gUajR/dDfu5TaTVuRxehavfQfMHlfWsO3rtYnoGyG3rWSWQWRyLhrqgKoE0VYFhI6QyofIu7I+igI0nmantDVAJv3i1XxL0itfttgSk0fgZO14ukDV0AloHvoJhr8EXDaCkXB9vHnWZPeg/xEHU9itlDf8aGm3gNRXQ/QeCeodN0CwkUZVTllPH0HEw+IUITkcQq59rMc7mUEmbyGcaTseYyGpZ0rTy0wJqzcVkZWvhBryAIG32uD+SsF92yq0MVHRgMs+IInQ0NF1qdXOeEFLCciH+1OK9nE/V0NCsm6J1yJIhkKKZt8ZFCT7XXdXxG3+8V0Z+XhBobG3vQlpAV0z4TEtnrKb4PwPwYxirt5MSHCyj8dkB3LG5fKTwONYg13LApZvGfou3kMOb9lRaNyO2Xr+Z0Jowj9wALAqKZ4pw07Jr3Xl27TZ4VRUnfN3ce3/IXmijM4AABrdxACSqIepc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c794e5-99a9-407b-6dfe-08d7f8fbb9f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:53.8304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Sk0traduTdlCH1a7PR7lPJRYqAgT6Fqj0d6BQHa1hrMDBIoNZ061s6PR7QOGZoOhhOUpmBe7Ap1RKrmZHGCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[WHY]
Currently we're copying the entire bios image into vbios.  Loading time
for FW with entire bios(54272 bytes) is 105138us.  By copying only the
sections of bios we're using(4436 bytes), loading time drops to 104326us
which saves us 812us.

[HOW]
ROM header, master data table, and all data tables will be packed in
contiguous manner. The offsets for the data tables are remapped to their
newly packed location.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 98 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 37fa7b48250e..7fb62780e8cf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1877,6 +1877,103 @@ static enum bp_result bios_get_board_layout_info(
 	return BP_RESULT_OK;
 }
 
+static uint16_t bios_parser_pack_data_tables(
+	struct dc_bios *dcb,
+	void *dst)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	struct atom_rom_header_v2_2 *rom_header = NULL;
+	struct atom_rom_header_v2_2 *packed_rom_header = NULL;
+	struct atom_common_table_header *data_tbl_header = NULL;
+	struct atom_master_list_of_data_tables_v2_1 *data_tbl_list = NULL;
+	struct atom_master_data_table_v2_1 *packed_master_data_tbl = NULL;
+	struct atom_data_revision tbl_rev = {0};
+	uint16_t *rom_header_offset = NULL;
+	const uint8_t *bios = bp->base.bios;
+	uint8_t *bios_dst = (uint8_t *)dst;
+	uint16_t packed_rom_header_offset;
+	uint16_t packed_masterdatatable_offset;
+	uint16_t packed_data_tbl_offset;
+	uint16_t data_tbl_offset;
+	unsigned int i;
+
+	rom_header_offset =
+		GET_IMAGE(uint16_t, OFFSET_TO_ATOM_ROM_HEADER_POINTER);
+
+	if (!rom_header_offset)
+		return 0;
+
+	rom_header = GET_IMAGE(struct atom_rom_header_v2_2, *rom_header_offset);
+
+	if (!rom_header)
+		return 0;
+
+	get_atom_data_table_revision(&rom_header->table_header, &tbl_rev);
+	if (!(tbl_rev.major >= 2 && tbl_rev.minor >= 2))
+		return 0;
+
+	get_atom_data_table_revision(&bp->master_data_tbl->table_header, &tbl_rev);
+	if (!(tbl_rev.major >= 2 && tbl_rev.minor >= 1))
+		return 0;
+
+	packed_rom_header_offset =
+		OFFSET_TO_ATOM_ROM_HEADER_POINTER + sizeof(*rom_header_offset);
+
+	packed_masterdatatable_offset =
+		packed_rom_header_offset + rom_header->table_header.structuresize;
+
+	packed_data_tbl_offset =
+		packed_masterdatatable_offset +
+		bp->master_data_tbl->table_header.structuresize;
+
+	packed_rom_header =
+		(struct atom_rom_header_v2_2 *)(bios_dst + packed_rom_header_offset);
+
+	packed_master_data_tbl =
+		(struct atom_master_data_table_v2_1 *)(bios_dst +
+		packed_masterdatatable_offset);
+
+	memcpy(bios_dst, bios, OFFSET_TO_ATOM_ROM_HEADER_POINTER);
+
+	*((uint16_t *)(bios_dst + OFFSET_TO_ATOM_ROM_HEADER_POINTER)) =
+		packed_rom_header_offset;
+
+	memcpy(bios_dst + packed_rom_header_offset, rom_header,
+		rom_header->table_header.structuresize);
+
+	packed_rom_header->masterdatatable_offset = packed_masterdatatable_offset;
+
+	memcpy(&packed_master_data_tbl->table_header,
+		&bp->master_data_tbl->table_header,
+		sizeof(bp->master_data_tbl->table_header));
+
+	data_tbl_list = &bp->master_data_tbl->listOfdatatables;
+
+	/* Each data table offset in data table list is 2 bytes,
+	 * we can use that to iterate through listOfdatatables
+	 * without knowing the name of each member.
+	 */
+	for (i = 0; i < sizeof(*data_tbl_list)/sizeof(uint16_t); i++) {
+		data_tbl_offset = *((uint16_t *)data_tbl_list + i);
+
+		if (data_tbl_offset) {
+			data_tbl_header =
+				(struct atom_common_table_header *)(bios + data_tbl_offset);
+
+			memcpy(bios_dst + packed_data_tbl_offset, data_tbl_header,
+				data_tbl_header->structuresize);
+
+			*((uint16_t *)&packed_master_data_tbl->listOfdatatables + i) =
+				packed_data_tbl_offset;
+
+			packed_data_tbl_offset += data_tbl_header->structuresize;
+		} else {
+			*((uint16_t *)&packed_master_data_tbl->listOfdatatables + i) = 0;
+		}
+	}
+	return packed_data_tbl_offset;
+}
+
 static const struct dc_vbios_funcs vbios_funcs = {
 	.get_connectors_number = bios_parser_get_connectors_number,
 
@@ -1925,6 +2022,7 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.bios_parser_destroy = firmware_parser_destroy,
 
 	.get_board_layout_info = bios_get_board_layout_info,
+	.pack_data_tables = bios_parser_pack_data_tables,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index b1dd0d60d98e..441768aa53ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -89,7 +89,6 @@ struct dc_vbios_funcs {
 	bool (*is_device_id_supported)(
 		struct dc_bios *bios,
 		struct device_id id);
-
 	/* COMMANDS */
 
 	enum bp_result (*encoder_control)(
@@ -131,6 +130,9 @@ struct dc_vbios_funcs {
 	enum bp_result (*get_board_layout_info)(
 		struct dc_bios *dcb,
 		struct board_layout_info *board_layout_info);
+	uint16_t (*pack_data_tables)(
+		struct dc_bios *dcb,
+		void *dst);
 };
 
 struct bios_registers {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
