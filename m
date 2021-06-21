Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238CC48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A8F60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A8F60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581E86E24E;
	Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4156E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiuzSNQwSVD3/T5MeAYl9r2ZOcWRWKVDChfXtbt3JEwsw/gCrufZWc7jIjhPNZpW4zrqi3A/4is3J+h+zef2Zz6IMrtX8rnt0YpUZp/NTpwcM/ivv2F3AY6wpWT1O5YOx3JGndMUgipieNY8jdO2QkRYvxBG+i5JpUxq+ddKM4P57LfkFOiQoWBb5FkYmgaJEL11GDicHK+FD89/6z0FCjbusx+Ln4+nmoaaeLPfLeyqf0rMAAqB0gsp9MNRgZfJskDWJ0SZm6LuX4yhcEsol3GiNrc9tI2SghEWlK2z0UQP3n8E2taOp7dOnTYY2NDla33DJhBQBZ28h1CUILPRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnXeLSu4SqT6HMG2ZfIAIc9bdTkmKwE8erAPpOZgGkY=;
 b=S1zuvaNrn2c0WdEQEh51Jxf9STyqZJOK12fT0GqRx0bPuighxGnUhO3noKdh0myF6XrTKj43jeRon4qz8lNhi/h2wCTkBUw4Z96JIXrnCindhMBmmycTA1EMcWGCYoIHM8hSickZxyldmhmYppL/bATMb5JpSRNv0VtVxtBhWbWcE17B+JuQ4H7EOJ72o38WDPDP3CtDvkhbI8lHByd9a2fgFjJVMbuPnQ5Mj3TnDN5FQx6YBhbuy3XjcCl7WRS3Qr8bqwaTO+ExBcVpgvWeXVn55/nCzUq+iRBwpPsk3eqLRncAMZ93vuberWMQS2LLRZRKxcx2fFkTv4mPmGSwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnXeLSu4SqT6HMG2ZfIAIc9bdTkmKwE8erAPpOZgGkY=;
 b=UBnxJiYbWnKU/OJNp6Mw5vgyql3Q79HiBA9om/37CjmQimv2nuVYqMkx5DZSwkIeUYoK64pYXYUlXu4ErEXzmuW7IBQkAWRJkU+t26n/y48xzCJmTdjQcf8YnxBuJo8AeDP7w2uXzQvaegnRYPxviPsamkmSQwBGJvPikvLhOcI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:33 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:33 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/43] drm/amdgpu: Nerf buff
Date: Mon, 21 Jun 2021 13:12:14 -0400
Message-Id: <20210621171221.5720-37-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb227ff-1785-4a8b-9853-08d934d7d4bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29853F0EFF4000E38102EA17990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWAJaQ9o2vqzIYgTMuA2ca1c9e0JgK0zvtuLvE2KwKZ86FI74Qr0jnhq54YRn42Syp6YIp7veP9SgwDYuEPvQXY52l/V76bbG1xzFU6ZOPBgft+LTCOg7KIGQS8FGBzktMbNBUHYNL52jM0EYWbL5pFfOj+IsNuLFVX98/vaeXGvPV9nBoIq/4mdxnBFnEga9x1yYi7O3EpzPh9FsEc0osyadQjCWUde13yYHpsTfn924lATSY8Krqkn2SAH2RBhMFpqRwLZxvUYe4Hd9PIX6TfqvMN3Dw/gd/83MkmwoDaFYX3qBu7c2ckC5LIK3DxiJbYy347BGRdBmNBQvNr1asRUVQIKHsbxKoacfwL1lSbQihC+kNhoY7cDxG+bJBnH6XIcJCR9+9XWxx2ElYmnPJk/aumMSX8X6iU51OQfIwjp8dbyceLcyqEt3ykc7CqqRBODfrzgyDtLIvpnoSyXDs3Cp8yB+4ysVNatncLuslV/oVKLpN/qldzzeueYkyJ5pDhe0HoF/Oi3ETcsKVXQeF5Kh4FmP/3ChKD9JsCfZ3CHb3694x8Vq/3jBN9JyfZjTzQkiTWkhtjAoQY9Wi7M28o9mKyLAmFyvijxkTZH9L0LREAIi/Bfa6qlAL82m4JbDsZDD0FdrEFyZAyECz0eRiXLcfv6Vl26rbwyqy16ZsYov7w7pMfguvAvbQam0QHy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63KpqZFJgJ3bH9wu55CP8alUaXf0GNte/VG/JEifqTL46eElpaeBwhtYI8CE?=
 =?us-ascii?Q?2tvzr+gUNLuyXvqB/rAF0RMTwETfMHAeIceksNN6W/Pw5dsjL4WGeo/rx6Tz?=
 =?us-ascii?Q?mK6DEmbPH6SwJ8lVZoDxCi2BgxIB53EThWwxS5A9kN+e5zwoLDY1CHyxjKYM?=
 =?us-ascii?Q?fZaBeHu05IH87aDHxvskriMcfJhYreIDrv8I4SW8wYbn79548p+Ygmv+5fKT?=
 =?us-ascii?Q?18/JQ41++P0bb6ps2aQK4kjE53PqVUWaLtrFvSMUVxZJNjfL6SoTFzLF7ZPA?=
 =?us-ascii?Q?0RyDT5Vq0zI27LbhHdHcBIN24rFfn+R2PyfcvcqUccRbv+VJ8aBgiD4Nu/q2?=
 =?us-ascii?Q?bhZ9DdUggxcfCuSuH9TJe88I8E8Cv8OxqzTPvuyzYfrF9LBpK9fo+QWCV+mG?=
 =?us-ascii?Q?PcVoPajFGfkrQxtS3ualwWE8Zsos9JLP645pu9DPNIaMQ6QOz8wjryDXHWny?=
 =?us-ascii?Q?HyDUUuIbJeQ9aozYE7tb0ihIW/yVHpUQgVDI9Y0Qf7bDasqXl/3Xv9EdEWcH?=
 =?us-ascii?Q?02Fcny8M1/Lyowo1P++vYWaUyD9AsNIjmg5OnNmaBQlbaYEShzhTKN3yfuR7?=
 =?us-ascii?Q?e4qVJ9cZcf2E1G/sLUyHG3LhB+Xb8neZt8EtqBPOAbsFKcBlWL9XfbS3DkD9?=
 =?us-ascii?Q?IK7taxhIQtqgbFBKGQvW0zFNLhHtFJUKoqHxtKTSxeFU+Y5SLeQd/OVKffq6?=
 =?us-ascii?Q?+CpsTkRrMxr7fTp0W/+RV+Qd+t1QYnEfj40ihlPY8FCrp+RlcO6KwSQh8OoP?=
 =?us-ascii?Q?Znb1NoB3Gx5lJrub87Yq1d2TF9qOc5ZhOWJv9Dj5Cx/B8YSvPBzzGKRAVPCj?=
 =?us-ascii?Q?mZBb8V7ovOh5WMLHSu57l31EOjSo4A2IdkxUHZN7tw+zHMygFO4677tWj80V?=
 =?us-ascii?Q?WQcbWefcO8H+Gn7Ea8PvNQN32uIaugwKyK2ACvpeh1Eo9JCZkadgkFSIsuK+?=
 =?us-ascii?Q?y4Ox7hbTOzIpSPcnMsVdnoycBuNijlm4zt8EZ+OCeAIn8mLrNIFfFsUcHnkZ?=
 =?us-ascii?Q?ncAGvmOlN3HuK/Avx/gqIlXumLcHeUltQKAC6fYJs1DdnjkgKv8SqnWA1eJ4?=
 =?us-ascii?Q?aUADbRRCUW+xv2LnfZRNbHb98Z6w0MzkfEKMdd7IcyPnVOEqDeyR/SLyUwR7?=
 =?us-ascii?Q?i/NahADHfnzpPmJucAcDIAoaJea6mn5Fa3MINKEgUMC3ZLoR64otP1jcs0Mc?=
 =?us-ascii?Q?zazDNo/gRkmtMfbIGduUHWd2vCoSFPesginWLAXsaGPZ1NlNNuMgQ/2gLgQ6?=
 =?us-ascii?Q?lzlD31d3lZEy6AC+nrcQ0uufdGMq629yt8TIQjdDOjcYrWZzy1lEQuxWKnib?=
 =?us-ascii?Q?fNB5cYHBx/GeGUgGO5jdL+uo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb227ff-1785-4a8b-9853-08d934d7d4bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:04.2592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVP0OZfw9e5Yy2ZiD5pvRI4ZNWIOvBbIp4e+HqxwyRvPzV0A/FtEb+mUqjkUUf3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

buff --> buf. Essentially buffer abbreviates to
buf, remove 1/2 of it, or just the iron part, as
opposed to just the Er,

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 +++++++++----------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 21e1e59e4857ff..8b60fba9f835e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -117,10 +117,10 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 	return true;
 }
 
-static void __encode_table_header_to_buff(struct amdgpu_ras_eeprom_table_header *hdr,
-					  unsigned char *buff)
+static void __encode_table_header_to_buf(struct amdgpu_ras_eeprom_table_header *hdr,
+					 unsigned char *buf)
 {
-	uint32_t *pp = (uint32_t *) buff;
+	uint32_t *pp = (uint32_t *) buf;
 
 	pp[0] = cpu_to_le32(hdr->header);
 	pp[1] = cpu_to_le32(hdr->version);
@@ -129,10 +129,10 @@ static void __encode_table_header_to_buff(struct amdgpu_ras_eeprom_table_header
 	pp[4] = cpu_to_le32(hdr->checksum);
 }
 
-static void __decode_table_header_from_buff(struct amdgpu_ras_eeprom_table_header *hdr,
-					  unsigned char *buff)
+static void __decode_table_header_from_buf(struct amdgpu_ras_eeprom_table_header *hdr,
+					   unsigned char *buf)
 {
-	uint32_t *pp = (uint32_t *)buff;
+	u32 *pp = (uint32_t *) buf;
 
 	hdr->header	      = le32_to_cpu(pp[0]);
 	hdr->version	      = le32_to_cpu(pp[1]);
@@ -142,18 +142,18 @@ static void __decode_table_header_from_buff(struct amdgpu_ras_eeprom_table_heade
 }
 
 static int __write_table_header(struct amdgpu_ras_eeprom_control *control,
-				unsigned char *buff)
+				unsigned char *buf)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	__encode_table_header_to_buff(&control->tbl_hdr, buff);
+	__encode_table_header_to_buf(&control->tbl_hdr, buf);
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
 	ret = amdgpu_eeprom_write(&adev->pm.smu_i2c,
 				  control->i2c_address + RAS_HDR_START,
-				  buff, RAS_TABLE_HEADER_SIZE);
+				  buf, RAS_TABLE_HEADER_SIZE);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -240,15 +240,15 @@ static int amdgpu_ras_eeprom_correct_header_tag(
 	struct amdgpu_ras_eeprom_control *control,
 	uint32_t header)
 {
-	unsigned char buff[RAS_TABLE_HEADER_SIZE];
+	unsigned char buf[RAS_TABLE_HEADER_SIZE];
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	int ret = 0;
 
-	memset(buff, 0, RAS_TABLE_HEADER_SIZE);
+	memset(buf, 0, RAS_TABLE_HEADER_SIZE);
 
 	mutex_lock(&control->tbl_mutex);
 	hdr->header = header;
-	ret = __write_table_header(control, buff);
+	ret = __write_table_header(control, buf);
 	mutex_unlock(&control->tbl_mutex);
 
 	return ret;
@@ -256,7 +256,7 @@ static int amdgpu_ras_eeprom_correct_header_tag(
 
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 {
-	unsigned char buff[RAS_TABLE_HEADER_SIZE] = { 0 };
+	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	int ret = 0;
 
@@ -269,7 +269,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 	__update_tbl_checksum(control, NULL, 0);
 	control->next_addr = RAS_RECORD_START;
-	ret = __write_table_header(control, buff);
+	ret = __write_table_header(control, buf);
 
 	mutex_unlock(&control->tbl_mutex);
 
@@ -282,7 +282,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[RAS_TABLE_HEADER_SIZE] = { 0 };
+	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
@@ -303,13 +303,13 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	/* Read/Create table header from EEPROM address 0 */
 	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
 				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE);
+				 buf, RAS_TABLE_HEADER_SIZE);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
 	}
 
-	__decode_table_header_from_buff(hdr, buff);
+	__decode_table_header_from_buf(hdr, buf);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
@@ -341,57 +341,57 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	return ret > 0 ? 0 : -EIO;
 }
 
-static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
-					  struct eeprom_table_record *record,
-					  unsigned char *buff)
+static void __encode_table_record_to_buf(struct amdgpu_ras_eeprom_control *control,
+					 struct eeprom_table_record *record,
+					 unsigned char *buf)
 {
 	__le64 tmp = 0;
 	int i = 0;
 
 	/* Next are all record fields according to EEPROM page spec in LE foramt */
-	buff[i++] = record->err_type;
+	buf[i++] = record->err_type;
 
-	buff[i++] = record->bank;
+	buf[i++] = record->bank;
 
 	tmp = cpu_to_le64(record->ts);
-	memcpy(buff + i, &tmp, 8);
+	memcpy(buf + i, &tmp, 8);
 	i += 8;
 
 	tmp = cpu_to_le64((record->offset & 0xffffffffffff));
-	memcpy(buff + i, &tmp, 6);
+	memcpy(buf + i, &tmp, 6);
 	i += 6;
 
-	buff[i++] = record->mem_channel;
-	buff[i++] = record->mcumc_id;
+	buf[i++] = record->mem_channel;
+	buf[i++] = record->mcumc_id;
 
 	tmp = cpu_to_le64((record->retired_page & 0xffffffffffff));
-	memcpy(buff + i, &tmp, 6);
+	memcpy(buf + i, &tmp, 6);
 }
 
-static void __decode_table_record_from_buff(struct amdgpu_ras_eeprom_control *control,
-					    struct eeprom_table_record *record,
-					    unsigned char *buff)
+static void __decode_table_record_from_buf(struct amdgpu_ras_eeprom_control *control,
+					   struct eeprom_table_record *record,
+					   unsigned char *buf)
 {
 	__le64 tmp = 0;
 	int i =  0;
 
 	/* Next are all record fields according to EEPROM page spec in LE foramt */
-	record->err_type = buff[i++];
+	record->err_type = buf[i++];
 
-	record->bank = buff[i++];
+	record->bank = buf[i++];
 
-	memcpy(&tmp, buff + i, 8);
+	memcpy(&tmp, buf + i, 8);
 	record->ts = le64_to_cpu(tmp);
 	i += 8;
 
-	memcpy(&tmp, buff + i, 6);
+	memcpy(&tmp, buf + i, 6);
 	record->offset = (le64_to_cpu(tmp) & 0xffffffffffff);
 	i += 6;
 
-	record->mem_channel = buff[i++];
-	record->mcumc_id = buff[i++];
+	record->mem_channel = buf[i++];
+	record->mcumc_id = buf[i++];
 
-	memcpy(&tmp, buff + i,  6);
+	memcpy(&tmp, buf + i,  6);
 	record->retired_page = (le64_to_cpu(tmp) & 0xffffffffffff);
 }
 
@@ -440,7 +440,7 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 				  const u32 num, bool write)
 {
 	int i, ret = 0;
-	unsigned char *buffs, *buff;
+	unsigned char *bufs, *buf;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -448,8 +448,8 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	buffs = kcalloc(num, RAS_TABLE_RECORD_SIZE, GFP_KERNEL);
-	if (!buffs)
+	bufs = kcalloc(num, RAS_TABLE_RECORD_SIZE, GFP_KERNEL);
+	if (!bufs)
 		return -ENOMEM;
 
 	mutex_lock(&control->tbl_mutex);
@@ -485,27 +485,27 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 	 * 256b
 	 */
 	for (i = 0; i < num; i++) {
-		buff = &buffs[i * RAS_TABLE_RECORD_SIZE];
+		buf = &bufs[i * RAS_TABLE_RECORD_SIZE];
 		record = &records[i];
 
 		control->next_addr = __correct_eeprom_dest_address(control->next_addr);
 
 		/* EEPROM table content is stored in LE format */
 		if (write)
-			__encode_table_record_to_buff(control, record, buff);
+			__encode_table_record_to_buf(control, record, buf);
 
 		/* i2c may be unstable in gpu reset */
 		down_read(&adev->reset_sem);
 		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
 					 control->i2c_address + control->next_addr,
-					 buff, RAS_TABLE_RECORD_SIZE, !write);
+					 buf, RAS_TABLE_RECORD_SIZE, !write);
 		up_read(&adev->reset_sem);
 
 		if (ret < 1) {
 			DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
 			/* TODO Restore prev next EEPROM address ? */
-			goto free_buff;
+			goto free_buf;
 		}
 		/*
 		 * The destination EEPROM address might need to be corrected to account
@@ -516,10 +516,10 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 
 	if (!write) {
 		for (i = 0; i < num; i++) {
-			buff = &buffs[i * RAS_TABLE_RECORD_SIZE];
+			buf = &bufs[i * RAS_TABLE_RECORD_SIZE];
 			record = &records[i];
 
-			__decode_table_record_from_buff(control, record, buff);
+			__decode_table_record_from_buf(control, record, buf);
 		}
 	}
 
@@ -539,15 +539,15 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 			control->num_recs * RAS_TABLE_RECORD_SIZE;
 
 		__update_tbl_checksum(control, records, num);
-		__write_table_header(control, buffs);
+		__write_table_header(control, bufs);
 	} else if (!__verify_tbl_checksum(control, records, num)) {
 		DRM_WARN("EEPROM Table checksum mismatch!");
 		/* TODO Uncomment when EEPROM read/write is relliable */
 		/* ret = -EIO; */
 	}
 
-free_buff:
-	kfree(buffs);
+free_buf:
+	kfree(bufs);
 
 	mutex_unlock(&control->tbl_mutex);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
