Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74286C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4EC60FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4EC60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE2A6E154;
	Mon, 14 Jun 2021 17:47:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AFE6E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxmRL80rg2QEl7DN0l20wadSHSVLZ1ilRNDm2SV94drR5DvKCVNd2LxJlRuBOI86UngLlrEnHso8v+8nG+GhHjBJ3PU7XMoOxZOHTjhAKsFKCazqzh3iFQHH9NVJJMgucuFuhqFp0A1r0MW8V0+2IwuNSNymqJysz7qItbRUFHBhAS/wvHV8mYqGiHAN5gsomWCs4HOTEo4jfYi1Zxje5hATdsKUOhKVaNP2K3Qv/gvRlNH205BO/PD6YrG75b5EB1zLWIXnVLk/h3taiqDikX6/TRnIYeqioqbSqHrS21Qx/WptTXRQxke0yL5NetsqSEtBOAZVijx3fjZD7D3lDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aW7ZVVRZenFeUpewa+/RsiZuxHUnLtcahdRgYbM70=;
 b=FBMBeTZpWoOUvEgBeLP3af5QmyNwlT+5z6wHq6XCM0V16inwiA8JBNvpIuR4FI2FfHlroncs2TwYSs6DGsZKdP0qdinLtoNDA2oS7XTyy3MZsg5gPrJh4Dp8zO8x3dKyibY/+Sb1i6F0A/Qi8zDlGooy0e2k8aJ0KI23kbrP9MXLhqX+BQoe1ggzLyjpETneF2HYYlLJz3ZOzIIUGgAiRnHUdsY+xSQrHD8INthjs2XBfQ5hjLuHyCSES1w7tJYjDWXvfbug5Rthr6vDtEMbCKV7S5dDo4YLlfeSagodEDj2wiFIQ59RXxmIQ18IZ822WibaKmiFodXvCxnML27Ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aW7ZVVRZenFeUpewa+/RsiZuxHUnLtcahdRgYbM70=;
 b=hDdPjrj7fQJxmPKmKzQuEHTn9pdOBrCDqA1ijqaUA9KZK8kdUbKGvXw7oo7+xdZ9V1E2uZEdujaHvXCNNYwcU0nEWD6HZzipUrKai6q/SbM0DdMiDSP0U16MgV8X5sjFvUY96qqJXPVG1epqzYHzaYvb0QLMTv0JVzdYNnxkAt4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:11 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amdgpu: EEPROM: add explicit read and write
Date: Mon, 14 Jun 2021 13:46:20 -0400
Message-Id: <20210614174632.20818-29-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f054f43-5e24-4332-1afb-08d92f5c6feb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35772C953DED36480F259AB099319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUR2x62K2Li/Q/IX+KVO2YcteWo77z8MLCkOBV7XPK+3Jh+sbTkisIDIU8EmsxO29hywZ+8pVj55i4gGexLlpxec/xTgb6H+sZowKRIELm9ClLxUodGyV7N8y6vSQH8hyMOq/m5O5MZ4799Cu4PFUpyEQOSp1P1PvGIkD0kiW2FbThXHka5RcmGpm43nO6twOD0MgzRmuTINZcr9+Bdta/Ewg/Vo8GhKB98qsZUIDTDSbVrZmOc1pUmsc9JATCKQ8z7DcGJBWTp9bP8hpzBkSo6tlRsGjN5y6xMlir04W+h8GA1nzt2uRnkI2/pNVP4rcdz9ogqOWXJ2MTQzsoJTzUQ7bRlVi+YuTyQ5VKaKcb2iq8xpYNoctjZbZJWxnis/HRRkMPgIRdh0xyefvYed0xiMPF4uz3o691PLT083jdHj7Ke9WaGPe0c0/CrwaAMZBtbbY6HzD5F+hKzR28iEwjq03mYQ3RiBPKPNZFgRhGiTE5mrVnnNgtB2+zmoHKq0lXqDluptJWbSlihRzM7fAKSGZenLsjAhQTqKni91zn1mhZj6aK0I/0PKdi504f+sL7oVCyiQ77Vlt9BPF4yP4BGmRhYmc4rdvC50YrVW/qpSgIlLbyQXIkd9x5TsJhQBl3gDF2VHaOGY4OGRuLGhjvUJaXOKxLEDSQf7pP+SrEhmUdK2yecyKlG8nhRewbrl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQ/UDkmZot0+ONc8AUbol6/jak/75SgSnMm7Xy2SwM+GvVy5OAmvxf1X/tPe?=
 =?us-ascii?Q?lhYGNDZcFqjySDxB1n+xnIwCtDcpGFcSE8dYQHu9ztfTbv4Zjo1UGDwIzoFV?=
 =?us-ascii?Q?PYuehv7L2JYvVb/T63gnma1CRNj3ho8Oekm+Yf4IpmhMpjRHfjc7D/NcGjnW?=
 =?us-ascii?Q?pr3WP2rgkd5SL7gQpnseQCp3rnX2GF0uu07h1LaTL8yR2GRtU/Wm9JYO14Ag?=
 =?us-ascii?Q?mtY/4iHML22LRQgbDdW0XFrw4VXrqf+oguqQxo9AKV3nGqE8A/EqT1iity3Z?=
 =?us-ascii?Q?eg6GPKkaBYECEsg2WMwum36CmqozStwGZ365/bHl7Na7O6jnboTCIc37cxJ2?=
 =?us-ascii?Q?F9j5vr3PJwoTXdy7xYxRTyhKinVFekIvS4LWFlwN+cx/NoQH3SyW5Car9vTl?=
 =?us-ascii?Q?lMz1zuGzLnSdDcTFcLClBL85RBRcHzj+lONBTDlIUnE/J/wxH2NuFvrP4y9A?=
 =?us-ascii?Q?6oJB1J+3u/SbW1GuzoqPzEwHXok6OK8OLC9ohiVlFExvMwCxOHA4G9LZ5fM0?=
 =?us-ascii?Q?3W5xkayuEU1lBSNDLadWRd9PoS0HZKLX5GJcY5iIzUY3t0J3ZKq+sMxt62J0?=
 =?us-ascii?Q?e09TNO/MCFt/MeRvqgPucBAZig9KC4KFc9+eQmzGpA2dGcaSl0f+zq2twznN?=
 =?us-ascii?Q?3QB55lSeoVoyw+eeWojhBqIcVF2V4tVP2vZBUc4uBIy6fz0GpvIuTrENultV?=
 =?us-ascii?Q?irk5KyVx0+Hb5a+3HQWYAFIWhi9W7/bNiNbH2pTTZKdcrMnO4GSSdQmA5P5R?=
 =?us-ascii?Q?HBhAP8/5BHk8C9DxuTQNlirnIivcHawP8QurAqadvr2HjJiCn2wrcrx9kpsq?=
 =?us-ascii?Q?QIG3y0dldPAxBu+N4eL2GPZpOLfArpE1NOYMNcBQ83U9IdXbaHkRk36P95d0?=
 =?us-ascii?Q?jDAeavj28USZwk7K9pOM/AXYjbot7lFpbi49S7VmdRLX0sSPs43kK6+nhbep?=
 =?us-ascii?Q?ODMpOLZyU3PbDh7ZWs8d8lmlbAKtxN4o8KKxmmpL5zuHYu3HGcIYAtuyq04f?=
 =?us-ascii?Q?5oxd/Z7vFIpdYJ3rzfHzTVVibJujM52WkoNxbcGcccBzw69SHnDeDAr20Qc1?=
 =?us-ascii?Q?LCudr4vKUrJeB3RRiX4so0/8nkgAC9j5vumyvd1th/ikK/iBcEnx5rqQ3Mwy?=
 =?us-ascii?Q?umMfShKNEkRxuOGB6N9I8aEtszQGjqcvQBsmSset7FwP6InAmWWLO/e3RUJP?=
 =?us-ascii?Q?cuVgZS6nLlU0523NoxxekeX0ugQa2CCsD3KMO2TGO5uVOxcIy3SLJHTunCOb?=
 =?us-ascii?Q?1HnemzrX8H58j8jwzNu9lW+3DVTE1Z8HOg5s9sHdDUnAfKZ7HsN5q1BESUzq?=
 =?us-ascii?Q?wFDL1ja64c2Ce3Lip+fcW7WH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f054f43-5e24-4332-1afb-08d92f5c6feb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:11.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsbBEhpDD2va064anabaeaizf9R4Hklry8HQAYsxtzQSoJHiZFw5lkCB6IguUKxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add explicit amdgpu_eeprom_read() and
amdgpu_eeprom_write() for clarity.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 417472be2712e6..966b434f0de2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -29,4 +29,20 @@
 int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		       u8 *eeprom_buf, u16 bytes, bool read);
 
+static inline int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
+				     u32 eeprom_addr, u8 *eeprom_buf,
+				     u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  true);
+}
+
+static inline int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
+				      u32 eeprom_addr, u8 *eeprom_buf,
+				      u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  false);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 69b9559f840ac3..7709caeb233d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,7 +66,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr, buff, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -77,8 +77,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
-				 true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr + 1, buff, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 550a31953d2da1..17cea35275e46c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -151,9 +151,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
-				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, false);
+	ret = amdgpu_eeprom_write(&adev->pm.smu_i2c,
+				  control->i2c_address + RAS_HDR_START,
+				  buff, RAS_TABLE_HEADER_SIZE);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -298,9 +298,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	mutex_init(&control->tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
 				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, true);
+				 buff, RAS_TABLE_HEADER_SIZE);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
