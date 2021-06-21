Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3280C49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D32D6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D32D6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385406E252;
	Mon, 21 Jun 2021 17:13:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2626E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVOCKtGkwLYGPOPIinckIdk1q4Pt7lNSkkeV5sEmx9tkVj98UL9cps6g2XGlQSEP/3rt1+2dx6BMHzg0iGMrYNONZFpnIToBF6PGUHzLk0URR9NkE80nE8KKyz/zq9IIDHUPEpmPh/lFumGIYlWrKue/xBE9X/gK+5bQhTZhfLrGomxpnau6aP6siTI8EMskt7jQ5flSoko6Bxz23JEQsXe4dltYrutiG2BkRloY4jK/qYxt/KMWZq0NNiKiCv6eUkxGy8smxX5ZMA2XTLCMYpSfh0MyEHtznIStZNmt8Ep4K/tqtrEKp4Wu/ciS/aFy8x1ieVrWPc42ec2QCblcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXrkxodD/5Xj9XX9wbrxAebN8F8vGlXkjCvPSCrjznI=;
 b=CKT6Q3el3PTFf+nT7WKbj02CqjzaFzQ93eNhCuyI4RJrMJRok1rfh5/pj31ypiJt9NKBWeKCRaBEBWICK7LHxEVBjUywjGB7yzwFbMZNzkk+J2LZ4snXzljt2BEHfs48SbxL39uGYHAaGnsRzTu2dCblMjqXTLyDMnXL7h0+n9hw6OklWWmjvdIlk826TFZElDclPlnpyKUSTxnwhUeYnWxwHIXLLKRF8M6EQBcnF7ZDR8HsaRVmNigYzehJRRVqh+/hDATy9lNuBqCDq0B/MQTBhwQGuP2rF5/qBpB52ls6xbUNWsiIFupN/sDh0PQKdjN/odEXTpq8W8phg1QKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXrkxodD/5Xj9XX9wbrxAebN8F8vGlXkjCvPSCrjznI=;
 b=x/qcYvDlmikKO0fNVTsm8Uc21ss3F/fvt2r+/Jgxpti6WQo4Uy/xuZUhLRD/3XiUmNcydSOtNk0o/hqf9MdGlErgFeY1SmPne5TQsKLMeTyqefS6+zNAKo8xVwRkDe8z/q131j3OLjh3rhG92TlTsOiHABklxHEG4PbkRPflN5w=
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
Subject: [PATCH 37/43] drm/amdgpu: Some renames
Date: Mon, 21 Jun 2021 13:12:15 -0400
Message-Id: <20210621171221.5720-38-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa3e17fe-2d4c-4e29-54b9-08d934d7d51f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29856986FC6F0C5D0A5D8A9B990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cdCcOJqO7/bp1mE7bmYUMQWcvEIehrTG6rz4u7Gh0mXy+QMMyhCn3QoQNFTLMcJAfGqrf6V9hlK6bTxmPmB8DsXq50BA7RaAfOzv18e1VXCRO+OGygxDwL+SmHpBwyVbI5zyAdaX/uW1Jno9gbOSGztgdcs+qJEEHsaNXx00ZsOYvRAmAoGP1ps5D/EAnK49tYGHNixePjPt5G480shR9tBcd094MUgv9PtJDVJr1AIep7f4aS57h2n8o0U/JIPY1L6bvuCn8UXEVCtNBUcQAbrfFseZ72b1Wz+MOPpM76et8kCkeV25/eK/Aa3pzKuHikR3dzZU8axe2bLBrddsEceOYE3sWWJHsIsITOE0H7lGwnpq6u8B1ci36AL2NfeLI+g3AK93RAhPKx43lufLKRRK5TIOG+KfIWl4SEL27Qy4xw7QjOu/7y1Fc/FIWDGheRU0uZNEzbr1RYZIwP3IIV0Eg9H+ojpJs/fU5Jo72trXqRaysT2o0u+k9EysSKCkyknEU5WJhB9qsJQLIdQo+JJSBQFdZrDvoW9YKWpTuTWTIqW6U/pUViSc5usfYc2MoQbct2czcv3lvoUrAgsO7TI8tKdAWLEYn1oDsLaQWA+Ut2iCVlN5EQxsXu5FD5XsDY9F2ojDJBz3B32Kjibu/0NeM+Gr9Zm5JN8RBWsAqVrSWmDPbiXRaZHIF5WyyyX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYUW/VN1oF5TH/Eh4Ab6/P7LPuVUJ+g1QvL0MWhMW7luBEKw1G20kITtKprU?=
 =?us-ascii?Q?Ks0QDqzoXwHfoSpYfN37h4nqcix4YnwUpP3302CyeG3q/yAUeNqVuQ1vgnrn?=
 =?us-ascii?Q?dgzIg1siE53N5RHeYByn+4f6DTI4myjyzB01EBikufXK66KYW4CZcvHHlwy8?=
 =?us-ascii?Q?949twi88Hi0MC55VITrutx7V9UO6FcB0Hz4K7OV4dQIivByGpRiQu5khUtJM?=
 =?us-ascii?Q?Te50J5tvkTIhdct3XOUVwwQ9vXl1ZJzsxkpTxC+ja4d9VnP4xbdV9m7abBXp?=
 =?us-ascii?Q?yLSXxIpK4J/kCBgcKO6eRA5YnSSEKKJHO+ga8vvGkOnDhyzGykpm9DN41EfZ?=
 =?us-ascii?Q?jpgrfr2Hq7rL0Wrsr4+yXZU22pw70D1p5u4NFEcoM8vWi3OoFm6ogrxxaTjm?=
 =?us-ascii?Q?0uFAJhZc4rd3rjq7aTJtbP3YaNpdFobXt0446SpIttHbr7O3H5PIRh/XFIRd?=
 =?us-ascii?Q?BpHDmyqLHAvkZhP+1uu+MijKhr6W1ZSs6UDISnwxJI2w2B8MV9X1tqpD4Yqr?=
 =?us-ascii?Q?S7OWjHPDuU7y+juDiqShCQ5BaJg2m+wdEz3UjwwzXheK3wP9PVqQUQ496G+U?=
 =?us-ascii?Q?g0hC0sM524WNE+aFnL62hmLKIICMDqp2Ebh59ztVG26guMZ4LIOMDq/zqPFM?=
 =?us-ascii?Q?yyBsjzvfq+X4pJnyExOXRUv6GN6ISiiweyLynh2Yv+9hvjqilt24xTh+Kcbd?=
 =?us-ascii?Q?lwUNoE/ylNTUK5RSXk+LSJv7Jf6wxX889iSc0YBtM4So81nvCypovyyywPqx?=
 =?us-ascii?Q?wnrVIS1BlmYwCdioU559vGgAiXIEl2PEBgT4HRl2qoMb9gZtdSo1CKkcQVOe?=
 =?us-ascii?Q?wKVPO/XUsNx6m1MTFTkdWwynbsZw7JxP5qJIoj9FJYqTDiNFQ5RN98Pzb8Z4?=
 =?us-ascii?Q?2zLZzSVbKbfvOTB/nH7VCs10ZfHSRkRSVhwXVGMs+iBDKiVlL4N6jgwlOi7O?=
 =?us-ascii?Q?GO06grZjzpEBcskt+7T1f7zLOcMmgRdbEIWJFzk6aQdKeMEdN0OWBBUBrngb?=
 =?us-ascii?Q?G76odAzodgu7gwRUPMXT0RVC0HSDWXOdt/bp/OH1N79DpeGoSJsTzffEjRuz?=
 =?us-ascii?Q?TZYR7p0UXQ3CwfglRYb01OiDnxBNehfwCtZfjmhSuNO5cNG7P/mkGZZH8SCY?=
 =?us-ascii?Q?vkicEMupJBlmFD8k6i+GZsBuWaBvcirhe+mNpDi34RboMxW8GTdnf/zyESpn?=
 =?us-ascii?Q?SJv8FsQ278q/DDGIPJPVcYEA4M8fPZhyZwz02FSjXhltwsGRCb+sBJ79MIe/?=
 =?us-ascii?Q?OFn9/qbKyLOSGUiORoi4PaC4GWy4qN1O9EnURwf8oHck+Qvo0vVtvEL6xB/v?=
 =?us-ascii?Q?6NgpGjueHIF6vckwwU4Ne7N1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3e17fe-2d4c-4e29-54b9-08d934d7d51f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:04.8998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utgxCrjobtyyqkX7lDVhuHEn25EPsj/Ov3MQ9hUIK1SBhxHIB8+TjaIzWakwde7B
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

Qualify with "ras_". Use kernel's own--don't
redefine your own.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 16 +++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 30 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 25 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 4 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c7ad90483f21d3..cd2fce8bbcab87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1818,11 +1818,11 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	save_count = data->count - control->num_recs;
+	save_count = data->count - control->ras_num_recs;
 	/* only new entries are saved */
 	if (save_count > 0) {
 		if (amdgpu_ras_eeprom_write(control,
-					    &data->bps[control->num_recs],
+					    &data->bps[control->ras_num_recs],
 					    save_count)) {
 			dev_err(adev->dev, "Failed to save EEPROM table data!");
 			return -EIO;
@@ -1846,18 +1846,18 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	int ret;
 
 	/* no bad page record, skip eeprom access */
-	if (control->num_recs == 0 || amdgpu_bad_page_threshold == 0)
+	if (control->ras_num_recs == 0 || amdgpu_bad_page_threshold == 0)
 		return 0;
 
-	bps = kcalloc(control->num_recs, sizeof(*bps), GFP_KERNEL);
+	bps = kcalloc(control->ras_num_recs, sizeof(*bps), GFP_KERNEL);
 	if (!bps)
 		return -ENOMEM;
 
-	ret = amdgpu_ras_eeprom_read(control, bps, control->num_recs);
+	ret = amdgpu_ras_eeprom_read(control, bps, control->ras_num_recs);
 	if (ret)
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	else
-		ret = amdgpu_ras_add_bad_pages(adev, bps, control->num_recs);
+		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs);
 
 	kfree(bps);
 	return ret;
@@ -1974,13 +1974,13 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	if (exc_err_limit || ret)
 		goto free;
 
-	if (con->eeprom_control.num_recs) {
+	if (con->eeprom_control.ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
 			goto free;
 
 		if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
-			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.num_recs);
+			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8b60fba9f835e6..34da00ef8369bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -246,10 +246,10 @@ static int amdgpu_ras_eeprom_correct_header_tag(
 
 	memset(buf, 0, RAS_TABLE_HEADER_SIZE);
 
-	mutex_lock(&control->tbl_mutex);
+	mutex_lock(&control->ras_tbl_mutex);
 	hdr->header = header;
 	ret = __write_table_header(control, buf);
-	mutex_unlock(&control->tbl_mutex);
+	mutex_unlock(&control->ras_tbl_mutex);
 
 	return ret;
 }
@@ -260,7 +260,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	int ret = 0;
 
-	mutex_lock(&control->tbl_mutex);
+	mutex_lock(&control->ras_tbl_mutex);
 
 	hdr->header = RAS_TABLE_HDR_VAL;
 	hdr->version = RAS_TABLE_VER;
@@ -271,7 +271,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	control->next_addr = RAS_RECORD_START;
 	ret = __write_table_header(control, buf);
 
-	mutex_unlock(&control->tbl_mutex);
+	mutex_unlock(&control->ras_tbl_mutex);
 
 	return ret;
 
@@ -298,7 +298,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
-	mutex_init(&control->tbl_mutex);
+	mutex_init(&control->ras_tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
 	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
@@ -312,17 +312,17 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	__decode_table_header_from_buf(hdr, buf);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
-		control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
+		control->ras_num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
 				    RAS_TABLE_RECORD_SIZE;
 		control->tbl_byte_sum = __calc_hdr_byte_sum(control);
 		control->next_addr = RAS_RECORD_START;
 
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
-				 control->num_recs);
+				 control->ras_num_recs);
 
 	} else if ((hdr->header == RAS_TABLE_HDR_BAD) &&
 			(amdgpu_bad_page_threshold != 0)) {
-		if (ras->bad_page_cnt_threshold > control->num_recs) {
+		if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
 			dev_info(adev->dev, "Using one valid bigger bad page "
 				"threshold and correcting eeprom header tag.\n");
 			ret = amdgpu_ras_eeprom_correct_header_tag(control,
@@ -452,7 +452,7 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 	if (!bufs)
 		return -ENOMEM;
 
-	mutex_lock(&control->tbl_mutex);
+	mutex_lock(&control->ras_tbl_mutex);
 
 	/*
 	 * If saved bad pages number exceeds the bad page threshold for
@@ -466,10 +466,10 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 	 * further check.
 	 */
 	if (write && (amdgpu_bad_page_threshold != 0) &&
-		((control->num_recs + num) >= ras->bad_page_cnt_threshold)) {
+		((control->ras_num_recs + num) >= ras->bad_page_cnt_threshold)) {
 		dev_warn(adev->dev,
 			"Saved bad pages(%d) reaches threshold value(%d).\n",
-			control->num_recs + num, ras->bad_page_cnt_threshold);
+			control->ras_num_recs + num, ras->bad_page_cnt_threshold);
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 	}
 
@@ -531,12 +531,12 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 		 *
 		 * TODO - Check the assumption is correct
 		 */
-		control->num_recs += num;
-		control->num_recs %= RAS_MAX_RECORD_COUNT;
+		control->ras_num_recs += num;
+		control->ras_num_recs %= RAS_MAX_RECORD_COUNT;
 		control->tbl_hdr.tbl_size += RAS_TABLE_RECORD_SIZE * num;
 		if (control->tbl_hdr.tbl_size > RAS_TBL_SIZE_BYTES)
 			control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
-			control->num_recs * RAS_TABLE_RECORD_SIZE;
+			control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 
 		__update_tbl_checksum(control, records, num);
 		__write_table_header(control, bufs);
@@ -549,7 +549,7 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 free_buf:
 	kfree(bufs);
 
-	mutex_unlock(&control->tbl_mutex);
+	mutex_unlock(&control->ras_tbl_mutex);
 
 	return ret == num ? 0 : -EIO;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 504729b8053759..9e1e7656b7bc2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -40,14 +40,27 @@ struct amdgpu_ras_eeprom_table_header {
 	uint32_t first_rec_offset;
 	uint32_t tbl_size;
 	uint32_t checksum;
-}__attribute__((__packed__));
+} __packed;
 
 struct amdgpu_ras_eeprom_control {
 	struct amdgpu_ras_eeprom_table_header tbl_hdr;
-	u32 i2c_address; /* Base I2C 19-bit memory address */
+
+	/* Base I2C EEPPROM 19-bit memory address,
+	 * where the table is located. For more information,
+	 * see top of amdgpu_eeprom.c.
+	 */
+	u32 i2c_address;
+
 	uint32_t next_addr;
-	unsigned int num_recs;
-	struct mutex tbl_mutex;
+
+	/* Number of records in the table.
+	 */
+	unsigned int ras_num_recs;
+
+	/* Protect table access via this mutex.
+	 */
+	struct mutex ras_tbl_mutex;
+
 	u8 tbl_byte_sum;
 };
 
@@ -74,10 +87,10 @@ struct eeprom_table_record {
 
 	unsigned char mem_channel;
 	unsigned char mcumc_id;
-}__attribute__((__packed__));
+} __packed;
 
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
-			bool *exceed_err_limit);
+			   bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f4489773715e65..0c7c56a91b251d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -134,7 +134,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 			amdgpu_ras_save_bad_pages(adev);
 
 			if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
-				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.num_recs);
+				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 		}
 
 		amdgpu_ras_reset_gpu(adev);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
