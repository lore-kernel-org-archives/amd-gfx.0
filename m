Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D28C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C931B60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C931B60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B38D6E2C8;
	Wed, 14 Apr 2021 07:26:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49A86E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 07:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuHHfFcB/vxhaytY0UfwwIjmSBNvk8ZwdIzvshZm9/HymlwEVSkjttww5gc9kayOuby258AUIpGiqsEPiX7QLSdJgmYwQhpTIZr2W/q5K+rW9tG+da75Qw/gpmKQewPtirrP+aT/QRKtZIhpNFFf1Rr3B862jJgTb1mYoD4208xWui3DzmUL635zLhFKXr6es8vmiC0fzJanGZGPxPXm7R1i4TIx0dV8en5BupRyWye+hgaVl1t9j8TQqnaUjSOIMqSIjBLimIiNC1EyZQnV+ijYe/db3L07NFc6pz92lNKfIpsGKi9D4nak8h5TrYAqnOKF+xlWWJvxyA2HEUs1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEFm4Vjk1S8AWsFgxybd8dvmonafWGuo+b4qu5KeO4k=;
 b=Gx6ioAGFzT0XcMl4q7vz8PB+2PsfWVTp6kGo72u6Ejmn9rbcZsSthrzOHuLwBJg+9qxFhAFAtKcw1vVJK9ZNYxZFD/OvtemidVtqjHKOGxSrm5A2biAMZvaVlGvaVzMVyLPxy/9xhX9s4HXZAS2AkotA4rMiybF4uBlyDMCuGCUHips2kaSPFQuz6q30eSpPg5oaISIIxkTLgpnZgjfjipMiwX61WBIbnZVHYJNIvQ9pd5v0ewK8knHHjBTuDoSzaOP5/u7dIUmZoMvTh8b97b4ovMoHkwOh7tf8fikerV7aHSFzT/rf7ABexqdAoV010O7plfu8U8EwJA1EBXqmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEFm4Vjk1S8AWsFgxybd8dvmonafWGuo+b4qu5KeO4k=;
 b=px5CSFgwEeN3Pf7j4JxucL36fiEp6o4avr0StWSNFgTwP6/DW7wmht0MPlqz7zBwB+uWOHmNCnI2TMSHVClwFVmkyTTWBjtss9hQL8o82jL1mrDWR9zEktuPTnQIro5MjS+9nXFFtJqp6/fzCjsrux9eCCkZqi/OnqpGb0KDErQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 07:26:41 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 07:26:41 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: revise two names of sensor values for vangogh
Date: Wed, 14 Apr 2021 15:25:55 +0800
Message-Id: <20210414072555.3279250-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:c8::15) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-vm.amd.com (180.167.199.189) by
 HKAPR03CA0010.apcprd03.prod.outlook.com (2603:1096:203:c8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 07:26:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40746919-7003-4be5-1ae0-08d8ff16a5b8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB162069F2ECAAAA4632BBEF03F14E9@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pelkZnBgzdPNZApfwyWJNkCPzPTgmxVWW/csFeZ56641twCylGh8Oy9PPw8KEtrPTsWzIB/UyNneuw4NYxfDNtVM/Yg53V2BQ/x97r8KXoIQaGwaFZbpm/8HCNRL/9YfO7Txlrll7g7lX+WPt825v80/a3kqQOXAzJV7WHlxQSAI/vbKFfX6W1ce3Snoiys78QS4O7W7PCO+Dt4+pZ3/oqxSQP4WzPsUoDak2af5LwqdFBVF9a8wXsDs63llLaW7se+6aeqoR8AV97s7YZkhJw9SHNy9S05L+ZEX019STd+xiH6kUPl6CDGFqVAP8Sa54P6gq+aMu6sPGsVoFrCnf4+qQX5LzRXDcxl4N6GLYaDcVYZBGr1L60rhck2UtbqqJccYVYKIWeoV7X85tmIIUQG8BSkAFKbVdlyEvPHtbGdbgu2BPG97T+ORxI6s6Bt/zhlA/7SEA2qa7x45xZPbxyFiQz7VjqRHkTIK7AIZBQAXVJa4dP7E2h0Ut+xBYTUNmAO6my3jm4ZrhDJAHM7ZG+jc+J4I7RbjJHKQY/6AFjbmSUpFB9IVNGEPN/siTGxXP1qwXrflxv4tbKIcD6sfrvrhcvigTYKj4e5aQ2agSW+gmZvvJJDcwzSkpmhTwzuwsc+kEGAna3DQxHRgkWEW2FnOJes09/+NEpEB/+OghI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(7696005)(2906002)(956004)(16526019)(38100700002)(316002)(478600001)(38350700002)(52116002)(86362001)(1076003)(66476007)(6666004)(36756003)(66556008)(6916009)(2616005)(83380400001)(8936002)(26005)(8676002)(6486002)(186003)(5660300002)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aPXTPWzUXo2XTYVOFfaHBEG+hIFxpKvljN/8Pi8ongz321kxxcUWEw7mEEP8?=
 =?us-ascii?Q?4bI+ahLjMCvrV62DpH6bAAGgnzefzCqa1r/NGjvx0f+MGuxbUS8Xym/or0El?=
 =?us-ascii?Q?kHwtzffAuFDhWsySKVQ0LWtXxLW2xBwtthBCGOkUuRRUu9uIkBLXikR6JsYW?=
 =?us-ascii?Q?gTAG1ob5cTlGPRJS9NhPFM9bM4s8owcKlNIsvQvxsozopXpH/AdAH/FGwkBt?=
 =?us-ascii?Q?048FnBlPeGys/wIxNKzPoFRKNAXaDBxySg0DfacEO34i5HJxcdIkeGyl8a4g?=
 =?us-ascii?Q?FEbhGqNPV42H+Ekb3rWd/5yQUfzLPoTUKOiV1COf6Uyp2AmvPnSpbRCB4VP2?=
 =?us-ascii?Q?aci9d4s0OB++WmDYBIsxbxE0qpldckZ/JCxUBW4/seLkNHsy99rTjHxaQjqj?=
 =?us-ascii?Q?jGvxW2BPsqUPvdJd2Gh906YDag5b3vo8Fns+NkAc1bwJitxzdyvzYRFqr8xz?=
 =?us-ascii?Q?atp7uRi+HGTIyKeCNCfvB2ZDWmlb/a3ZDCruyh1Sx5pO73SEhgHtJVOSjX/6?=
 =?us-ascii?Q?+qaPbT+GDYgc4SPdalJJXT3lak5c+wKAhB3Xe35C5gRpvSEESc+4ZlpIACH/?=
 =?us-ascii?Q?yf+lVtKFz7GWqjbOBQiZ6sE/KagsPmMKVAyke+8K1IRbdtvxNgags+KrCgMr?=
 =?us-ascii?Q?wIGRpy/oCYbRQaXDl5SBl9uFWMdYSi9PIr9MY90VqL7SnSAV+vf7pjz4IuXx?=
 =?us-ascii?Q?VrqohCTbzY1KeAxp5P+wvfWGvFbo+svxxDT/Ke8ka9jKhV+0LQgONvSuj7DZ?=
 =?us-ascii?Q?iY2dqzBw/bUvMBcbb19b4mR+/ND6fnOWHl37J7WxTZtc6DhNOqPmC3TCybTx?=
 =?us-ascii?Q?506eZxc+P/70tfm7v8K+jaxj/i0ZddyGpq6lG90Mua1m4tAiXw8Sy5mOzuu7?=
 =?us-ascii?Q?Yg/KdrcIOr/gE9vtLy8rnCrpBGa/S/zi6rD1eucVaPj8QNh6Ozs4c/+Z3/13?=
 =?us-ascii?Q?wat5a9yOZ/K5Z6BDDdGH+Jmbq8iKjSX88hQwljS/uFE3Z0Wc7gXObpwXTAuS?=
 =?us-ascii?Q?TtOAbVhZ+zZPdcvmNMmbk6kQVJoBHDRZBJG031HTo6t7QFryyELJiz4GIxGx?=
 =?us-ascii?Q?Zx8sIES8s/CZsXbziz4SKZh2js3yD02Mz5vHGcKh7YYBJNAqwYIZHD9X/8kg?=
 =?us-ascii?Q?ZqwzMO2U3AnbULx1ly5BeUoZgZFz8Il6jxv6K+DcFFj2csdfpckNshFs5j+F?=
 =?us-ascii?Q?KLbqoGtJbIWUgjZO98valu+4mLyRkm4E+LqqqD6yXo0fkzSGEyBHdyTEJ0hz?=
 =?us-ascii?Q?H7cDhJKPy/CBgQhFWomXwVHL9mhhAyd9Yc1IXksUsWgonjAFYn+3ucZ5pSQI?=
 =?us-ascii?Q?Ym+wKfjbAJoByH+voM2bPbt0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40746919-7003-4be5-1ae0-08d8ff16a5b8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:26:41.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ADVVl8vEQukfH5fF+lF43t+Cc1l/fys37YLVuoWisPYtZaWgDFf6KvboswmbEvJPTr+3nikTzLickfQ8gOW2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
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
Cc: Lijo.Lazar@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to revise two names of  sensor values for vangogh.
New smu metrics table is supported by new pmfw
(from version 4.63.36.00 ), it includes two parts, one part is
the current smu metrics table data and the other part is the
average smu metrics table data. The hwmon will read the current gfxclk
and mclk from the current smu metrics table data.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 35904315c1f9..77f532a49e37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -270,7 +270,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 	}
 
 	switch (member) {
-	case METRICS_AVERAGE_GFXCLK:
+	case METRICS_CURR_GFXCLK:
 		*value = metrics->GfxclkFrequency;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
@@ -282,7 +282,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_DCLK:
 		*value = metrics->DclkFrequency;
 		break;
-	case METRICS_AVERAGE_UCLK:
+	case METRICS_CURR_UCLK:
 		*value = metrics->MemclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
@@ -345,7 +345,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	}
 
 	switch (member) {
-	case METRICS_AVERAGE_GFXCLK:
+	case METRICS_CURR_GFXCLK:
 		*value = metrics->Current.GfxclkFrequency;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
@@ -357,7 +357,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_DCLK:
 		*value = metrics->Current.DclkFrequency;
 		break;
-	case METRICS_AVERAGE_UCLK:
+	case METRICS_CURR_UCLK:
 		*value = metrics->Current.MemclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
@@ -1529,14 +1529,14 @@ static int vangogh_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		ret = vangogh_common_get_smu_metrics_data(smu,
-						   METRICS_AVERAGE_UCLK,
+						   METRICS_CURR_UCLK,
 						   (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		ret = vangogh_common_get_smu_metrics_data(smu,
-						   METRICS_AVERAGE_GFXCLK,
+						   METRICS_CURR_GFXCLK,
 						   (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
