Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEBC49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4130F60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130F60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28076E23B;
	Mon, 21 Jun 2021 17:12:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C809E6E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxRGQE6DkhpG80i5Qfqt7rPPz1YDHv/v2aaIug/OoCrOYh1U5Q5uuYyDG8LlqHV1uD6/WYFFsJAabv4tGRlCdKCMdeW1QGPim9mAtmJ20SpgOOZRD6pPpfEMw7jdI8ML+aTa2X05orkQgb3ccXJ71ML2TfhQh8kEyw/52LvddgtOe/qoXzw4Qj9d/JfivgwlA1BTBSWZZHLuSz2CfgL4ZSuvHqhsCLBOmxT9jf0+3R9ExDW8s7SVPFkqr7ZGDJPITT7pg9f5L6UpNK3ie9ep3qxNTrlk8AfXZUop68a6EUGlGFn3Vr7HnWjfBUtuLJJN0k3UKWpHdlaOs1ytstiyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F1mY81XawKbGQoZ4p389W16fWbhlhzePibciJpBjig=;
 b=KuJqXQcN3DeS9STFSiYKKAFktRuF+1PPw5R91LlW9sc6Y07ZbG1kiQTGmGvZ4yslePIj1wWzCLrbYMKxjqSv1lWFLfuTuc1H5auswYLpmVgfTbbLUEwnPGtp6ynolpIfJxQiBUNS8F57QEUPVCpsIHFcNvQPajmtejmI8ZHMDGyyW6ulL7vQaIrzqZr7g/Fwk+50Vdp6BapU1oycfMN4CF1j8kwlgPqTx2NSvNjbquzDyYioAO29zjuuzCKEzvve+HtR+xGQMRv906F0W4AW4b+JzJt9yqoBo8bpw+Zd2F+dteDn2qoBOCxF+/I+uZCeilXOJIOQUepMeaUmx/D5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F1mY81XawKbGQoZ4p389W16fWbhlhzePibciJpBjig=;
 b=q6IrBtGtoSct3de5+AnRk+u7Af0Qt3Y1un5PwAgG3+8s2Tr7G7gKDAE8O8voSep80MBYv4024KOokWOhbdIYl0DNzrHwaYNTR9hc/wKriYFwU3yNTp174Lz8UlxpYiw578qKzZ7vPXDKwXejwTAh8Ouyb239xwxuhrCY9cO2neo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:48 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/43] drm/amdgpu/pm: ADD I2C quirk adapter table
Date: Mon, 21 Jun 2021 13:11:55 -0400
Message-Id: <20210621171221.5720-18-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80cf2494-6cc8-4199-7ec1-08d934d7cae5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865F2B4B2A8A9185C2B019A990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEIc7m7dCVq6/tZBrZ7cKTQOjeuGasGzzHDEWyfOb2jXT7ZKzWQ2qBVd09mZ7YMERoBfQpb6mu2vFWm91pHpnmcsd3h/a0ab7SqfXo5ea1gZG3wCINKf6ZX7TZzss4IpPfZDavkZSgaH1KQ5OLsNluJ0JF+kdpj92ik+c9fnDqZK0hbMHkU0z+BtjKPcnSgFmDULZTm3ncIma2M1DXjC83APvVHUs2sJh8npg8XTWjy4nx/7ivLd+WHH+1GvH0zhMErkzFOK0FwnnQzluwvem0kU+71QmFCTkInAC3kTgwyBJWFO3+WErzNlAwsgdftWNTlJeLXMihEGRGezTACRslQlMv+ZeYycpg9OOIDaoBcSXb6FrTjHhG/UqHC959PHeVWStSoMKqDlFXnA9ZyNB/A411jt+OG/pzSbEPzesoEc9+uhWeYE0obHy0gBUI04xzPccA0zb3xFddff302wsLRLm7rIzCz7Oe/HEoRr87gKr9l/caEjwdMo8dCiGuJ3tRel+25eohNsDhRpczzOTInJyIwNMN+7xAvpZ4qTxEaUthc6d9+0wCs+qGSCdZrDgWgF6DGzcqWFEujXr7QlsDphDR+YIel/pgUdc1/fEOviFZ6G7zmybw/ykpjfZprusvMNA/f+tOTBzSXCoxH+TjNFcDjq8Tp/ivDfV0H83AdB//JrR99AAyCYsZvseM7A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCPK3KbfFwXyMpuKTyR5PVIlbHags66e/gxSq/qu1L/7uWYRSrMkda6pyas1?=
 =?us-ascii?Q?GQT7ME5nLNKhd1EyjY5Ydxtb8UW2qd7BER4z3DcMzEHYfY3tWztLxg6SyLoK?=
 =?us-ascii?Q?fuZjPlTMJpAEI5GZ9HVoLH3W+DSRpidn4iCCZVoWlE6T/GlRMJdSBwBGtvLb?=
 =?us-ascii?Q?bfYpK14npuTkFVuh8OjGO3t89IhfhJONjcUSPE8a0HxAZD/3Zh8VfHKiiEAQ?=
 =?us-ascii?Q?me+bDylhxNNAH0D5nYR1Pc8kGK//+V6Yqny2bwAEKoWiUscE9yUVDyTr9XY3?=
 =?us-ascii?Q?AQfZizasfbaETEbrzc2FMXm9vYNqSXqje14whB3LGL7jB8l0gp2vMxrLKigB?=
 =?us-ascii?Q?KhRzKnmIOiWMKwlq39cTfILpSHfzU+pfjZRnqRVw5oMbMAKEBSUJLte23H8Z?=
 =?us-ascii?Q?Blke3sLhZ4R8vRLcbCpmug8hRcihsx+vmRogNvsq8WH/GeppwMpf1Ts2k1Vc?=
 =?us-ascii?Q?t3AXNzbLOktUteCf5LU2K684pQPOC/P7tXWQoCIcLxpcGAfiSJyExXH1f8C7?=
 =?us-ascii?Q?QNXVrvh2xqOfF6fhc3sjDioVbP4XB/fbXYRXzsRP7UCKCaRJ2jq4va8wcttR?=
 =?us-ascii?Q?S2dfzX59MsnmwxcrW5T1UeWVHus4dDVRm5koAXeEWKOAsVdH8WaXXq2Phc9V?=
 =?us-ascii?Q?fxVUYGuRum27KCZjUI8ljgOBt1hm6nCjW5mrSdyD+3POB+oSvsZ6t2xlaRhO?=
 =?us-ascii?Q?o1Uw6w/Jcjd/OK1D5hsWhODdIYTgXEhBzihQR+JbH+PxrxtcxloFUUoGG4Pl?=
 =?us-ascii?Q?uf1k+v7U8dxloFZL99nMBfuvCq9XEcsZsWXsWtc1V8fJH2vNNyIaa6g3KQnA?=
 =?us-ascii?Q?0ExOHh3E6K+oQjWrXHUsSG0yXwvODaVTTLGFSb1K7EwkgnFG8norFlnmOjbU?=
 =?us-ascii?Q?VkO+QCiqvs6t2lDzNjoYaxqmdeV9+uL+PTiTfr0iX8gt4RWazcBj+jV26AZf?=
 =?us-ascii?Q?bTGfvxcrOrTlocowQXQPmr6ncg1HayGVY8x7XzU0xgNfovvGwfzzrPLQRIGY?=
 =?us-ascii?Q?jAIkkEQwrSUQ44niTnEu4Nlc0rqiewpYb7xuCBX5/ZD3VoBQAEMicHWUdzyR?=
 =?us-ascii?Q?8q/L03tcW7wV194FSUYULn7lR0y8KKmxX2DpOrtgc/2clxdNAVS9eMTw9/JT?=
 =?us-ascii?Q?qQQYkwKuBErMW3XTJI2ejAnwhagZ6ZMgt4o6Qw680vsAzbBHpQ9Jj2d1QtUQ?=
 =?us-ascii?Q?aIgrUUGL3O2ZD4eWkHpmmsC04Hy19vRG7AN5CfG/YGFwHwoKrQ/ATFnEEVRO?=
 =?us-ascii?Q?MgnD1WyzM+DNAtmK/h3IaxJ8lI+eZG03fDieQW4QNWN08cjipGd7FukXL+co?=
 =?us-ascii?Q?PT3z9ZAyFhRQnqS1SxIepaKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf2494-6cc8-4199-7ec1-08d934d7cae5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:47.8475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFcokGkDam6vxJDlSlQUmPSayIhSCkM1RAM7mxLrdXA4myXFZZT23//O4ZYb8EDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

To be used by kernel clients of the adapter.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c916ccc48bf67f..33210119a28ec1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2034,6 +2034,12 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 	.functionality = arcturus_i2c_func,
 };
 
+
+static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -2043,6 +2049,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
+	control->quirks = &arcturus_i2c_control_quirks;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 
 	res = i2c_add_adapter(control);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7018716b6c8585..c9519a1a5ca633 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2833,6 +2833,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 	.functionality = navi10_i2c_func,
 };
 
+static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -2843,6 +2848,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &navi10_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8f8e5c7df44a12..9a14103cf9729f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3540,6 +3540,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 	.functionality = sienna_cichlid_i2c_func,
 };
 
+static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -3550,6 +3555,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &sienna_cichlid_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &sienna_cichlid_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
