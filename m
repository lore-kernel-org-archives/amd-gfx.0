Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477FC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 03:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC08A2250E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 03:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kLELADYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC08A2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D2889FDD;
	Mon, 20 Jul 2020 03:15:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807C189FDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 03:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjzDndbz2R2LFwzzfMv3DnMzvFlApB10XJUwm4b6RAdIwgc5skcDB7K+3Z34KRcbtXrweF/GNwFgzwmhOc2scAcEdWqhfj5wI03OsOy2f9A8bkvBzMAJpyB77L5Ev2HjbKdycOzvByOUhR99D6IcXvfoRDfjlflonRDh1mZbKJ7LJ2EXKDP3K1TpFhnEcOTR4gkoIXy1mSpC6q/wc1KhNgQt658oPLoB1ASLLBqyUt4bUCZAHX9PCbReNbKy0FaOQIap07NuGHn1M8HSt5oepjl959ax/k/DBawXDc1GqP2V2V2+7uzZpt0vTQLvjNazpDcbAwq9NyLOUI8gQDpdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owKz2KXbXt/sVg3pv+ctH9xRyjWtY5q20F/Bby0f/i4=;
 b=Xv3GyHeBsDB1UxNtMYeCb2EDSji25juuU3Lji2d+JOJuYGRUau63D0rrsyb9qfL6YmmN6ceAhD5nTiLczljkp9i4YlK+zqpcgHsHTMZ2BoyQGl92CWwqgaIQZ4kmfG/5dupHcKyZcwKRAcxzTGR7nW+MNCO/HhNYvnlY/kyXZAvpzmSvRuTTbZwsDhITraMdmmc5oGYLyYrGXhXc5hgDOEtOCF8N2LeRj915gS4VIo8JY40RdqBXiYFkD1kj44grbOtRx2sRpL+OXbqMtHbSDL/uI2Dp1LTr/j7wQQNtkSEo9jCAxiiS2aT3N++WFAn/zBKrkTju8HPoSO737TOafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owKz2KXbXt/sVg3pv+ctH9xRyjWtY5q20F/Bby0f/i4=;
 b=kLELADYekFddikzrDBYFwjWRI7KvjVCBFRsc0iTdIVYK+cnzVE97PFQ0w/ulrH8qybQDZPQ/HorKIo0LjxZJnN8T2gB01FVkiuW4Ptt6ri/kK4ku6rz1BkUoNbW+8awkny8VSDe00AXX8lOarlDLBHJeVMihylQDhs/k92JpRpo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1512.namprd12.prod.outlook.com (2603:10b6:910:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 03:15:54 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.023; Mon, 20 Jul
 2020 03:15:54 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Stanley.Yang@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: add printing after executing page reservation to
 eeprom
Date: Mon, 20 Jul 2020 11:15:36 +0800
Message-Id: <20200720031536.1822-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.16 via Frontend Transport; Mon, 20 Jul 2020 03:15:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2032b79e-0fd5-4855-ca62-08d82c5b3660
X-MS-TrafficTypeDiagnostic: CY4PR12MB1512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1512C8510BCC2F16AB83F48EF17B0@CY4PR12MB1512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H32Kcy0caBGpV1E4vQ+kezfNy5fIYnQ628uQ3hx3TRbV5Wtw1AyRfKxv1UXn4pP8BmIVyBTZ1Gy1rqU13bgfAkmJZaFI3K7MXzlGR1TXOAXHChvaW/opg/de37Ny5rxAGMMDeJHui9ZDZbL7ZL2lCOuBGHmbPLJZLk8AFOeR0V8Eg1XT3mpjEZ/s8uQUtSB1i0PwwfqA74+zWBEo7uqMNh0Us+m241hYIoXlT+P4U4qcFlK0nnvLZC8RuVjBWDOMdY9umy4sdTxpi1Js6/hd2be1DpRy8MNVaW5fTGr7xppDwybcv5z9GTi+eWxU8BarUf3RC/YowBsmX6hHtUA70Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(1076003)(44832011)(6636002)(6486002)(478600001)(956004)(6666004)(2616005)(7696005)(52116002)(316002)(4326008)(26005)(5660300002)(8676002)(83380400001)(66946007)(86362001)(66476007)(66556008)(36756003)(186003)(2906002)(16526019)(4744005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zNeHVdlJ+YaMk3kdUsUhwI1FYGyyn7TM0oXFPuLMS+Ibn6B6r6xWOxVKgs9sNgaQfOCYOiN4dt6UwiJ4fziXqzIyKcBYb63KNyiQY6mvq+Wv++saZc6iACEixRVGhvCtxwEIajJwwQM58bi48RzuG97g+jU5fbLGP/qXhoogVNhLdExoE1twrSBI7gjGcRH0JrkcmO8Lo/ym4T4/qD5hd/G0k53Nozc75uZEU/WABOw4IqqzhGvmaUSYFwF1SqNWZOnqzd8Bd7yyuou3aMQLca8ChkCyIEmJDuVjnVF6XiOTgcUZiqPyXkqZb3nUSUp3gjpgIWrfmrsZduFweRWD28T+3tIqH5IPq7ivuTLCpQ3xFDHBklVnHygq438ftTwjWswhMl+iv95UKY9TFw2Fl3LUCMw6/BJjKnAjuj5n1vuAzU2Uc+9D2BoUM0ZZ/8dbSKuxP/4C0U3i+Ro0rhML+w+V3oC6hgqwnG+S7Rl8Cuw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2032b79e-0fd5-4855-ca62-08d82c5b3660
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 03:15:54.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1ahEk7dFdLxsvIHv/JRG1kAAZEgYgdXRtO4bkF6WZ55z3DiWu4SfmR62ctijSNYXclAfoW0RPyfXlKsn8NOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1512
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will tell users if the faulty page has been written to
external eeprom device in dmesg log.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6f06e1214622..4a82a587de28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1622,7 +1622,7 @@ static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	data = con->eh_data;
 	save_count = data->count - control->num_recs;
 	/* only new entries are saved */
-	if (save_count > 0)
+	if (save_count > 0) {
 		if (amdgpu_ras_eeprom_process_recods(control,
 							&data->bps[control->num_recs],
 							true,
@@ -1631,6 +1631,9 @@ static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 			return -EIO;
 		}
 
+		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
