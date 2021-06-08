Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D6C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5A610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5A610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7026EC54;
	Tue,  8 Jun 2021 21:41:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30996EC54
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSK/ygeGDHA1w7PYZVi7HV04sUgf+oK/GDDlgViEMxo3zm6F++ujYsWwkcYkAn2EhQghcKYCrXs9FC1UZ0p+TzE3oeF5xNib4sH5tj9lZ2R/SXjQuSeEvyBtMUOlCis0jtBEvIaGd8LsekMuRvdSIhmajt85QaU4ybSYdZE7LMp34eIOURHXtfzE2CJM8wBgGlnm1SYU8KhVJi+tiuh6cPaNH9U/ebZSiaxowcAZ2axTJcVc4csrVc6D1+9S9D/Y3r/t2LXS0oYiGwduTtYlBlVcnJZpv2V4oE7ZbAblmvfxaU0/ooNOjN2ZGrF31HAj265zKl23MLmgSMst2YYUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxzcggdeqabvQhRn3owBPGOay3+U2Jh+HpHnPDPxVXQ=;
 b=oR7PAtAOt0Ove5pRPhMYM0p5MbVHAIgao7v213Wt/GNn3/HyDvg8wFU5yS8REhaTkXArCTGSzRSsnQNasd0EXr+Jpo8B8VIC4A/TezNzerUOHH3CMXrxZmMOeZRXdoZTaKWqujZLyesyVY8/UrWF+ALpZvVrm1fH8bjC3pX6ms/oWkW1GYBa3Cx6liPZaFSZ3vcssBuCNm4XVe6HD5ww4eNZNIIGhStZz/gF+gAjKGHXMismOl/8u+TB8ZaMsXPHZrRa4WfacJmifX/PHRf/z7YNWA0lSUpDxJryyhay83iFXkEePFNX5gMMqwe73Ry4kM5K+gT17CSDF0KhuIaOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxzcggdeqabvQhRn3owBPGOay3+U2Jh+HpHnPDPxVXQ=;
 b=2Mem78lLoJps9fFoVkbeLnbdo1ZnbQoAleKkbx2DVZN5GMa8IIzWkGMlCiESjCPG7H28L/ggFtH/X8KQGPt2LqFzNqw1DW46uUaQgtKe1R92ZW6EINCAoxOk2VJ5i478Y4yN3YUq6JuML0RJtEp+8XkgQ/7UIrgVTWa8eLxejmE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:15 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:15 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amdgpu: Fix koops when accessing RAS EEPROM
Date: Tue,  8 Jun 2021 17:39:53 -0400
Message-Id: <20210608213954.5517-40-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eed3b2d-d8fc-4518-da7e-08d92ac612d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678E1EA1A5F5C7099F69A4D99379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7XrOsrugP2Lv6NoWstvek23FnPoM4aMKUZehGkmjN+p/GCtjQQBD/oajN+6b+c2bnjcjlNygADEO2FYYAuXGBagM+sqM1Le0ak1rF4WZjCyYlelasdnkoDNTAQ1QoM1/of1LljYfz9kKilS1i0nU8zJqFMb5LQxLConFK5rKWS1wLXZA5WBgSK2W+/VRAvh81uEFWjbU105NIH/v4Cg7VU+6RrFVvVSHbpEn3QPwh9Ab8fJ3XaWTwUI35c4/ZzysFRsuovUDNaGxUe89Wuh5RTxs9YJ/IhWUpPCBTSTx3fsWySE0edTH4N66J+b7i/UK3cX5ru/BCHzt48Jf08A8AvoQvyAKYobzj2Wz/lkg1H8xgeCisKQOYk0CTN+Bk4dIc1Aj30RYmgpFLkJP/nWGbzyp0+TI1KRK3oPkw2SdLA5IEmLZ3VvloI23uRD9kYSO3wBgG7Zctmp7CeSi0nDju0Q7ZSU6JD3FcJo6jtFHo9PMUcaxB40BS5lm45fUHlF9n4JtkjMlPadzoFGWGlTn3S3B8b1RXXSKHGLX7sjf/n+gK2/+K5u/YkayFCJGFXaeZtmM4dUvKP2VBngBLGn628KdFnO0J0pEc1o70e8zuFd8vCyBEFZ/JTWjVJrdeBrKlSaMCe7gasyAT9sqn+FGmWm6EHkw7yaj4N2UzASaqYlpngO4IfTtRsOLRxULY0y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(6666004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOSwKbfhTiV+RA2n60QF8xqBi/DNTMLej8Py9KFJoJNcWOGku0xs6EUiAcks?=
 =?us-ascii?Q?07feON5oqF6Xpmswlqp5DIN4IEsFPXsTi+8ixtKATscyBp8U1pbF5US7wptv?=
 =?us-ascii?Q?yKZh1JrnhzVnFP+HTqgigr5iv/bVcfeIJm6PX0kvn3bCCdFy9isS3gtKBm2z?=
 =?us-ascii?Q?tKv0RC8Q1hLOQ+amIQNg3qVa9xMteEoJMYJaeMK7OPha1P+MKkRsrm5oaSTd?=
 =?us-ascii?Q?aBGRTlrNpbxqp06cMYuSDKfb6ivsKT5RWXlhaxgZgII8FeshRcDsCJA/eNiZ?=
 =?us-ascii?Q?UzcZVNd4fovCRr6Je93ksBNjLCoRZ2fHU1Tl9QeZw5ORNNFXTfiuo9mg04aT?=
 =?us-ascii?Q?OzzKIEFu4J2JG6pzEUPaf1Ohysi91uG/1DhIA/yxsNe5d02gsxAFaqFDbaep?=
 =?us-ascii?Q?WMFgjmmtWssAoymLBMj+uBGPqD/+MKynJVGtOu0+GoDo8kSyZl48VmUkDDIO?=
 =?us-ascii?Q?VNFagi5HThd7nXYKGxmHM+J2CQMP5Yqrz6QbVAdOQwPJ+1spDDkHx38rr//w?=
 =?us-ascii?Q?KeQvCinZZoaTQSGoaxC83C260BHLbx6E01x5Y7AAEapOgt07TE/M3yqK3Jwd?=
 =?us-ascii?Q?rNL4LUhoVFsW7pB06lTf/9yZIqoAnARMMGBfpWA454MbPbt5mb+likKbbySP?=
 =?us-ascii?Q?S+NhyNCnN2XKu/T9lRKp1Cnw0U1jmJsR97DJ1danDBT475x+eRZvppeyvwKx?=
 =?us-ascii?Q?2QVUeYmJo4+Ahn+hMiVly2k0t2Ov5nQ2PbGjS/Hha++cCDXmcRCBxmbiCOgF?=
 =?us-ascii?Q?xEGglQsNccPDvk9gFyNWVg+1wD4PGl5WOoCGW7LvRzzYgwt0LrMfmlcMYugy?=
 =?us-ascii?Q?/00TzCwDznNpRCIoDISWW+gq0YbMLlZho+BYgFltH/DZ9LZOqhnCuwwWl4Wz?=
 =?us-ascii?Q?TejPk+G4yjjwEsBxc32j9jaIJrewWCiQoGpvn2QBr8Cu5QXN4plRua+jbtLT?=
 =?us-ascii?Q?Mdi0XrzmH7J806vflgw/DxNBYCIHhZBpKh1SMPId/Lvi6ApB2z0y/mWyo3Yh?=
 =?us-ascii?Q?RTWLCKVRUa4pvDR91H+juwJ4x6GhVpMBUbjkszHSHsq+U/3G6FgRXSHLbRMH?=
 =?us-ascii?Q?GRwI5+kpipimxyceagjY0TZElqTxe1p/hdqoPK0XasZhR20m8IlvuR7AXFkb?=
 =?us-ascii?Q?5VkYWTkhV77t3QFHJeyrnbSihRAPmWZ2hll+VVFs6yN5uQSguycXOUHUF5DI?=
 =?us-ascii?Q?sYFyiorxzR4LdFQfbI9B7NophfD+PmsgWIcrJaM6iPWce1Wxh6cu5hhAmu/1?=
 =?us-ascii?Q?TRdSf+JVEPNZFq717i4kDZe6Xm0MAUe7NsqDxP6DS2LRMfLL7T9c+HmLdUq+?=
 =?us-ascii?Q?jczQX+U8Wc5F8uRmGML5qiFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed3b2d-d8fc-4518-da7e-08d92ac612d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:45.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcj1kepKkS8TJe2rxR76eagKug/rwDILCTlsQPPNseb4rzzesnoXuAgga3OojSk+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Debugfs RAS EEPROM files are available when
the ASIC supports RAS, and when the debugfs is
enabled, an also when "ras_enable" module
parameter is set to 0. However in this case,
we get a kernel oops when accessing some of
the "ras_..." controls in debugfs. The reason
for this is that struct amdgpu_ras::adev is
unset. This commit sets it, thus enabling access
to those facilities. Note that this facilitates
EEPROM access and not necessarily RAS features or
functionality.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d791a360a92366..772d87701ad4a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1947,11 +1947,20 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (adev->ras_enabled && con)
-		data = &con->eh_data;
-	else
+	if (!con)
+		return 0;
+
+	/* Allow access to RAS EEPROM via debugfs, when the ASIC
+	 * supports RAS and debugfs is enabled, but when
+	 * adev->ras_enabled is unset, i.e. when "ras_enable"
+	 * module parameter is set to 0.
+	 */
+	con->adev = adev;
+
+	if (!adev->ras_enabled)
 		return 0;
 
+	data = &con->eh_data;
 	*data = kmalloc(sizeof(**data), GFP_KERNEL | __GFP_ZERO);
 	if (!*data) {
 		ret = -ENOMEM;
@@ -1961,7 +1970,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
-	con->adev = adev;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
