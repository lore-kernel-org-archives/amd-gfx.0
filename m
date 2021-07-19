Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12392C07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC6461164
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC6461164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F60189BF8;
	Mon, 19 Jul 2021 13:27:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F381489BF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq6Bet2SzlLVqNkHEubQ8VwONE85fqqWVzuItjGXZ0i++Tc//592gA8FEYV/p7E08JHHob/oVthBFX0kGK6kcqhGvcEOS4nhpCzRv4Ej8UzmWCv/91FR3E40D8CHYHsNAvPKqnQuwJAguK3rPJatGJuXbcsGC6llIatbGsO+cHkLvJ//plxgG43e/fsHDKMdD84VV7mbv48cwWgQogT2reWlvl8G/85/Pph723tzX5nW2XMo7lu2a3izzWP+wRI6V7PjhXf/b0MMqwKAP/bS34gEnOk8VGbqQV8pUaXJrxvNpx9bnVTx8A8HVPMuwqOORUdmIcnmx4AfAmC4uzcCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G13YsWIKuKDm60g7eltCITaGzNg938FeeMPWMgnOivU=;
 b=nJ0WaFOi8xfxL78v+nFuhOm1Svj69SkPjt33d5zXYFiIWxtdfnl6YKYk6JxFLcHGK7SDOe3dyB0daHGM0EhR4Dzw2HvL+FaKSlmcqo7Me+G/dqz6Ts/cUeU2uU+4YrGmm30lzNxMyGgStwSqAy58yEWcWzswYZ3HncxtqOKj9DMRKSOCUQxlJc/i+fkw9U/iYaVK5NPsu/cmwDiaobpoH7vcLES8mpWTekwYRlEGgEdQ+ozkHqLnIwRSejZJY1UsSApbM+m7Za8M/PNB7ek/iD7CLCkw3VCC2oVo0oFAO1u7JSMjOudkJMzXTWc1oCKDIIx2Oy4zjO4XsZPsxASTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G13YsWIKuKDm60g7eltCITaGzNg938FeeMPWMgnOivU=;
 b=tQiziuFWwkV08a3uBzEP+lDJI5e/IQBng4551jna1SjBA+a5T7P/jG/ByRTwgo+HCLcOy4AUX/Sxpbt7qgrQA/SAz/Alz6ssIYlEnxa7QSKy+Io7kOxyMLFqVO43WktmYNq4kvAePo+V2oyhjAVhshASuYx4e1bicd8VsxsCTPg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 13:27:28 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 13:27:28 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v3)
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210714175817.20473-1-luben.tuikov@amd.com>
 <448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <af371cd3-547d-76c1-96bc-e35a5d6fdf05@amd.com>
Date: Mon, 19 Jul 2021 09:27:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd38e7e8-54c0-410b-a5d1-08d94ab8f3ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40926BE6B7815B0BA1FE55C999E19@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWXiKZPNG869I7vVRizHU5MLgq9XcYK/InxhX0Bx88txELUARA/HK/llJTzphygqV53WJ8fr4Qzsj9nT4HkqK1TPIzaCEiAI0JLeOTjLhVasdl4Dk8MipL2jeK/WM87y4et/LFFf5U1Bu6CjY8cw60O82HNT0nf6tY+pzdcaP0RbokS3L0Q5zzGbRpKyF44f5Y7xdHLrJICA3o0K79mTdXTX0x9icGY3uY2XhIAeczcIau+GyMoXY96M4QZ5+BYA3pRiHcHss6nmiiSYowHaJ5VQARLciB/4/CDFkHZcVbgp2yo++H0tIE+hrOtAqGVcMXMXoCCbSSGcp4r/2YvsEmtEK2sUUbhBptbDMqPq7CSB8QINvzDPgaO7IH8WehR0YzWjm4cHsi03oajaOMEE2kygaa3m6PsM1YPGm4hbSxzp6Ey4KZzCUzLr+EoevlbJ5rTsN5/1Ti5RoJTGy7+aKcUb+d8ZU4qEhUtLN4aKAWiQWCjGKWPk7g0+I9WwoApokHnXzEjfVb6T0BauXA/Ofgea4ae0EiuLc7hqMDLysftkttrx49PNWZxO46xQBbs3RsBDruAwzebrXH34+g+C9LcjHCnRnHfCFU68/g+za4xdX2od6eZp0a2R74HO4tatpR0qu0Jh3mClt8hhJ24rByYqIi4AM8o0+/bkLjPruZybr7qZVIGj3hCRjfoFQ3XUyr3Gu+IpBye29yiUGHk1XVp0MDaqE9Pif6rCls3Szx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(31696002)(4326008)(86362001)(66476007)(66556008)(6486002)(508600001)(316002)(186003)(8936002)(31686004)(54906003)(66946007)(8676002)(38100700002)(55236004)(44832011)(956004)(6506007)(53546011)(30864003)(2616005)(83380400001)(6512007)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FxSC8vblZHQTZiM05MUnp1bFhIaHRzN2JyaUJwZS9IVWdWdVFNcGVXWksx?=
 =?utf-8?B?QXJtVWJreTNnVzRYdkJvZmVFREkrR01BNUNtS1dKUU1lZ2F3MGZIWktTK0Jj?=
 =?utf-8?B?cUFUM0N0aWEvOVoweDVQVU5vZnhJbC9tMWZTNE9PSFptYVJpbzlMd1VvaGsr?=
 =?utf-8?B?Ym5tVXBhSVFySW8zVS9RdnR1c0g0cE1sRW0wdkRWeVl0SlZSR3BXa20vYkdS?=
 =?utf-8?B?WjFUb3pRQlAzczhtRUVaTzFtYkNkVTRxcU1lOWZqOVFVYjRvVWtNTW5hR2t6?=
 =?utf-8?B?ak9oY2RYdmJ1R2VISGE5a291T0k3Qm9pQXI5dnJ4UmZVMHBHSkdiOVk1d015?=
 =?utf-8?B?QWd0MzZIaWpWcnA5bTQwQWQwWk1pcEFiRDg0RmtyNUpwVHdkSEhDTHl0UzNM?=
 =?utf-8?B?VUg0bHUzR2ROdVQ2Y05Qejh4ckFCaFhrdjZmY3FPdFh2S1oySXJyM29sOUxt?=
 =?utf-8?B?V0Z1Mmsvb2NaVFhWb0FvYzVkMVRtM0JOV0hYOVhETzI2ZzJyRTV3RmtMWUFr?=
 =?utf-8?B?WmpMNXcyV2dCUkhVY0M2enFnTGwrRFJONzRiSHhrZlZMd0F2eFVOdThhSm42?=
 =?utf-8?B?amhHMnFkVktQQ2owMlM2NlhkQ1hQcWlZakFXa3hISkVmNzJjTlFMMlhZMFRm?=
 =?utf-8?B?MzRnN2VTandibUd4RC9abi92VVBlWm1IbUhKa01iUFJoT1VlY093RUt6NEZG?=
 =?utf-8?B?bkwxOG1TMnNXdUZIK3lqQmNOQUZwOHN4MHJ0Q24rbmVLQWRoemNkdHN2WTQy?=
 =?utf-8?B?bUxnbTZ5K3dzRWN6ODZYa2RnNHpueGE4c1lqUzQ1ZisyQkJhZTEwY2oyS1M0?=
 =?utf-8?B?ektpNWJrWlFVL1l1aGpyS3U0RlQxV1E1R2E5TDhTMC9DcTU0N1pRTHhUTW5S?=
 =?utf-8?B?UndBSmEwcHlPL2M5RHh2Z2FNOHdMZTh6MllGM1pXR2s4SmN2Z3Vibm81MzVX?=
 =?utf-8?B?MkNKMlJnejZjaUdsNWVWYXl6bENSbVZNQm4zMFhNQVBkOGNzSHpXY3I3eDlB?=
 =?utf-8?B?OGVZcTdNdFFwc0g1aGlsTzFpdExORTd1SUhpcldtWHNsM3orYWZDTHlGazZt?=
 =?utf-8?B?T1JvVUtVbE9HWXhmQ2pQbzNLbTV5VVpZY21CVVJLN0Vsd3Z0R0JENUd5VUlz?=
 =?utf-8?B?aEFYYk1MckI0YUs2TXBhYTNlK1RnNnArbzM4T05XU0szRFp1WU1XUll0cC9R?=
 =?utf-8?B?SmxXSUJ6VHI1OUhYNnBUTDdIWFBob1BHSFU1OURGV2dnWkVtNW9VQ0lKaEU5?=
 =?utf-8?B?YnRyK21qV2h3clh1N21pckJhcG9UMk45eUpOZGkzT2N3K0EySUt1T0JrSk5k?=
 =?utf-8?B?Z1ZnNmhRS2t5WkJpSnkybWpqNGJMdzlKN1RlSGF4T3p3TUlPV2lXbTBIYWoz?=
 =?utf-8?B?RXhxZ1ppa0pydlFLZUZ6bjBORnY4Z084MExsTmRhM3JPdnlWSWhxZ0F4R1Fo?=
 =?utf-8?B?QzA5aDRoUEs3NmlXSXpPQ1JXa05OMmtpMHEyTDJSWGF6RFh4QVI1Y2VLL2R2?=
 =?utf-8?B?NjJ0MnJtaVNUei9CcXFFd2t2ZG14Z1FMalYyZU1YL2xKSEt4WEZKNVpUR0F0?=
 =?utf-8?B?UFR6WlI3M3BSZ0l6TUcvd0VIYno3K3pBelVQbWlkd3VpSFFkV0IrT0tXTkNs?=
 =?utf-8?B?RXNIN282UW5QbVpYSUNzVUNvVFJYMkRQMHpnRjFvVkdIZEZPOEk0c2pvYis3?=
 =?utf-8?B?VlhrZ2hqaUFxWU9Kemt5dzJRU2ltTDM5c01nNWRsZlVMQ2xreXZLK2JWZ0J0?=
 =?utf-8?Q?uw7lkto+vzSzpGDLtG5xPZ7X59VNw0guf4vBXVe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd38e7e8-54c0-410b-a5d1-08d94ab8f3ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:27:27.8483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0h7tyanmJV1P07k1vNFz02k+vJGjTbarKIwFWjGjMV03kVbWJ07dboJA94EyCNRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1648099473=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1648099473==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2021-07-19 4:24 a.m., Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 7/14/2021 11:28 PM, Luben Tuikov wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This fixes a bug which if we probe a non-existing
I2C device, and the SMU returns 0xFF, from then on
we can never communicate with the SMU, because the
code before this patch reads and interprets 0xFF
as a terminal error, and thus we never write 0
into register 90 to clear the status (and
subsequently send a new command to the SMU.)

It is not an error that the SMU returns status
0xFF. This means that the SMU executed the last
command successfully (execution status), but the
command result is an error of some sort (execution
result), depending on what the command was.

When doing a status check of the SMU, before we
send a new command, the only status which
precludes us from sending a new command is 0--the
SMU hasn't finished executing a previous command,
and 0xFC--the SMU is busy.

This bug was seen as the following line in the
kernel log,

amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!

when subsequent SMU commands, not necessarily
related to I2C, were sent to the SMU.

This patch fixes this bug.

v2: Add a comment to the description of
__smu_cmn_poll_stat() to explain why we're NOT
defining the SMU FW return codes as macros, but
are instead hard-coding them. Such a change, can
be followed up by a subsequent patch.

v3: The changes are,
a) Add comments to break labels in
    __smu_cmn_reg2errno().

b) When an unknown/unspecified/undefined result is
    returned back from the SMU, map that to
    -EREMOTEIO, to distinguish failure at the SMU
    FW.

c) Add kernel-doc to
    smu_cmn_send_msg_without_waiting(),
    smu_cmn_wait_for_response(),
    smu_cmn_send_smc_msg_with_param().

d) In smu_cmn_send_smc_msg_with_param(), since we
    wait for completion of the command, if the
    result of the completion is
    undefined/unknown/unspecified, we print that to
    the kernel log.

Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Cc: Evan Quan <a class="moz-txt-link-rfc2396E" href="mailto:evan.quan@amd.com">&lt;evan.quan@amd.com&gt;</a>
Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>
Fixes: fcb1fe9c9e0031 (&quot;drm/amd/powerplay: pre-check the SMU state before issuing message&quot;)
Signed-off-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 274 ++++++++++++++++++++-----
  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
  2 files changed, 230 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c902fdf322c1be..dde10c51daa106 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -55,7 +55,7 @@
  
  #undef __SMU_DUMMY_MAP
  #define __SMU_DUMMY_MAP(type)	#type
-static const char* __smu_message_names[] = {
+static const char * const __smu_message_names[] = {
  	SMU_MESSAGE_TYPES
  };
  
@@ -76,55 +76,246 @@ static void smu_cmn_read_arg(struct smu_context *smu,
  	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
  }
  
-int smu_cmn_wait_for_response(struct smu_context *smu)
+/**
+ * __smu_cmn_poll_stat -- poll for a status from the SMU
+ * smu: a pointer to SMU context
+ *
+ * Returns the status of the SMU, which could be,
+ *    0, the SMU is busy with your previous command;
+ *    1, execution status: success, execution result: success;
+ * 0xFF, execution status: success, execution result: failure;</pre>
      </blockquote>
    </blockquote>
    <br>
    ^^^^^^^^^^^^^^^^^^^^^ right here ^^^^^^^^^^^^^^^^^^^^<br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
+ * 0xFE, unknown command;
+ * 0xFD, valid command, but bad (command) prerequisites;
+ * 0xFC, the command was rejected as the SMU is busy;
+ * 0xFB, &quot;SMC_Result_DebugDataDumpEnd&quot;.
+ *
+ * The values here are not defined by macros, because I'd rather we
+ * include a single header file which defines them, which is
+ * maintained by the SMU FW team, so that we're impervious to firmware
+ * changes. At the moment those values are defined in various header
+ * files, one for each ASIC, yet here we're a single ASIC-agnostic
+ * interface. Such a change can be followed-up by a subsequent patch.
+ */
+static u32 __smu_cmn_poll_stat(struct smu_context *smu)
  {
  	struct amdgpu_device *adev = smu-&gt;adev;
-	uint32_t cur_value, i, timeout = adev-&gt;usec_timeout * 20;
+	int timeout = adev-&gt;usec_timeout * 20;
+	u32 reg;
  
-	for (i = 0; i &lt; timeout; i++) {
-		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-		if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			return cur_value;
+	for ( ; timeout &gt; 0; timeout--) {
+		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		if ((reg &amp; MP1_C2PMSG_90__CONTENT_MASK) != 0)
+			break;
  
  		udelay(1);
  	}
  
-	/* timeout means wrong logic */
-	if (i == timeout)
-		return -ETIME;
-
-	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	return reg;
  }
  
-int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg, uint32_t param)
+static void __smu_cmn_reg_print_error(struct smu_context *smu,
+				      u32 reg_c2pmsg_90,
+				      int msg_index,
+				      u32 param,
+				      enum smu_message_type msg)
  {
  	struct amdgpu_device *adev = smu-&gt;adev;
-	int ret;
+	const char *message = smu_get_message_name(smu, msg);
  
-	ret = smu_cmn_wait_for_response(smu);
-	if (ret != 0x1) {
-		dev_err(adev-&gt;dev, &quot;Msg issuing pre-check failed(0x%x) and &quot;
-		       &quot;SMU may be not in the right state!\n&quot;, ret);
-		if (ret != -ETIME)
-			ret = -EIO;
-		return ret;
+	switch (reg_c2pmsg_90) {
+	case 0:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: I'm not done with your previous command!&quot;);
+		break;
+	case 1:
+		/* The SMU executed the command. It completed with a
+		 * successful result.
+		 */
+		break;
+	case 0xFF:
+		/* The SMU executed the command. It completed with a
+		 * unsuccessful result.
+		 */
+		break;
+	case 0xFE:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: unknown command: index:%d param:0x%08X message:%s&quot;,
+				    msg_index, param, message);
+		break;
+	case 0xFD:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s&quot;,
+				    msg_index, param, message);
+		break;
+	case 0xFC:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: I'm very busy for your command: index:%d param:0x%08X message:%s&quot;,
+				    msg_index, param, message);
+		break;
+	case 0xFB:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: I'm debugging!&quot;);
+		break;
+	default:
+		dev_err_ratelimited(adev-&gt;dev,
+				    &quot;SMU: response:0x%08X for index:%d param:0x%08X message:%s?&quot;,
+				    reg_c2pmsg_90, msg_index, param, message);
+		break;
+	}
+}
+
+static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
+{
+	int res;
+
+	switch (reg_c2pmsg_90) {
+	case 0:
+		/* The SMU is busy--still executing your command.
+		 */
+		res = -ETIME;
+		break;
+	case 1:
+		res = 0;
+		break;
+	case 0xFF:
+		/* Command completed successfully, but the command
+		 * status was failure.
+		 */
+		res = -EIO;
+		break;
+	case 0xFE:
+		/* Unknown command--ignored by the SMU.
+		 */
+		res = -EOPNOTSUPP;
+		break;
+	case 0xFD:
+		/* Valid command--bad prerequisites.
+		 */
+		res = -EIO;
+		break;
+	case 0xFC:
+		/* The SMU is busy with other commands. The client
+		 * should retry in 10 us.
+		 */
+		res = -EBUSY;
+		break;
+	case 0xFB:
+		/* Debug message.
+		 */
+		res = -EIO;
+		break;
+	default:
+		/* Unknown result from the SMU.
+		 */
+		res = -EREMOTEIO;
+		break;
  	}
  
+	return res;
+}
+
+static void __smu_cmn_send_msg(struct smu_context *smu,
+			       u16 msg,
+			       u32 param)
+{
+	struct amdgpu_device *adev = smu-&gt;adev;
+
  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+}
  
-	return 0;
+/**
+ * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
+ * @smu: pointer to an SMU context
+ * @msg_index: message index
+ * @param: message parameter to send to the SMU
+ *
+ * Send a message to the SMU with the parameter passed. Do not wait
+ * for status/result of the message, thus the &quot;without_waiting&quot;.
+ *
+ * Return 0 on success, -errno on error if we weren't able to _send_
+ * the message for some reason. See __smu_cmn_reg2errno() for details
+ * of the -errno.
+ */
+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+				     uint16_t msg_index,
+				     uint32_t param)
+{
+	u32 reg;
+	int res;
+
+	if (smu-&gt;adev-&gt;in_pci_err_recovery)
+		return 0;
+
+	mutex_lock(&amp;smu-&gt;message_lock);
+	reg = __smu_cmn_poll_stat(smu);
+	if (reg == 0 || reg == 0xFC) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The FW spec for the protocol calls this response register, let me use 
the same term here. Except for the initial value and while caller 
initiates a message, this always contains the response code given by FW 
to a previously sent message. FW doesn't use it as a status register to 
update its busy status, the only chance this could change further is if 
FW updates it again with the response of a pending message. So I would 
like to confirm the check on 0xFC (FW being busy now) again with FW team.</pre>
    </blockquote>
    <br>
    Well... Go ahead, confirm.<br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

The other aspect which we discussed is - what if this register contains 
a response code which is not one of the defined error codes. In the 
past, we have seen such cases which indicate a possible FW hang. 
Proceeding to send message when FW shows undefined behavior is undefined 
software behavior as far as I see it. This similar to a case when 
software detects a hang or undefined behavior with any other component 
and, instead of poking the component further, does error handling. Since 
the FW has not defined any such method to handle this case yet, prefer 
to do an exit here.</pre>
    </blockquote>
    <br>
    I can do the same thing here which I did for _with_param() below.<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		res = __smu_cmn_reg2errno(smu, reg);
+		goto Out;
+	}
+	__smu_cmn_send_msg(smu, msg_index, param);
+	res = 0;
+Out:
+	mutex_unlock(&amp;smu-&gt;message_lock);
+	return res;
  }
  
+/**
+ * smu_cmn_wait_for_response -- wait for response from the SMU
+ * @smu: pointer to an SMU context
+ *
+ * Wait for status from the SMU.
+ *
+ * Return 0 on success, -errno on error, indicating the execution
+ * status and result of the message being waited for. See
+ * __smu_cmn_reg2errno() for details of the -errno.
+ */
+int smu_cmn_wait_for_response(struct smu_context *smu)
+{
+	u32 reg;
+
+	reg = __smu_cmn_poll_stat(smu);
+	return __smu_cmn_reg2errno(smu, reg);
+}
+
+/**
+ * smu_cmn_send_smc_msg_with_param -- send a message with parameter
+ * @smu: pointer to an SMU context
+ * @msg: message to send
+ * @param: parameter to send to the SMU
+ * @read_arg: pointer to u32 to return a value from the SMU back
+ *            to the caller
+ *
+ * Send the message @msg with parameter @param to the SMU, wait for
+ * completion of the command, and return back a value from the SMU in
+ * @read_arg pointer.
+ *
+ * Return 0 on success, -errno on error, if we weren't able to send
+ * the message or if the message completed with some kind of
+ * error. See __smu_cmn_reg2errno() for details of the -errno.
+ *
+ * If we weren't able to send the message to the SMU, we also print
+ * the error to the standard log.
+ *
+ * Command completion status is printed only if the -errno is
+ * -EREMOTEIO, indicating that the SMU returned back an
+ * undefined/unknown/unspecified result. All other cases are
+ * well-defined, not printed, but instead given back to the client to
+ * decide what further to do.
+ *
+ * The return value, @read_arg is read back regardless, to give back
+ * more information to the client, which on error would most likely be
+ * @param, but we can't assume that. This also eliminates more
+ * conditionals.
+ */
  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
  				    enum smu_message_type msg,
  				    uint32_t param,
  				    uint32_t *read_arg)
  {
-	struct amdgpu_device *adev = smu-&gt;adev;
-	int ret = 0, index = 0;
+	int res, index;
+	u32 reg;
  
  	if (smu-&gt;adev-&gt;in_pci_err_recovery)
  		return 0;
@@ -136,31 +327,22 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
  		return index == -EACCES ? 0 : index;
  
  	mutex_lock(&amp;smu-&gt;message_lock);
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
-	if (ret)
-		goto out;
-
-	ret = smu_cmn_wait_for_response(smu);
-	if (ret != 0x1) {
-		if (ret == -ETIME) {
-			dev_err(adev-&gt;dev, &quot;message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n&quot;,
-				smu_get_message_name(smu, msg), index, param);
-		} else {
-			dev_err(adev-&gt;dev, &quot;failed send message: %15s (%d) \tparam: 0x%08x response %#x\n&quot;,
-				smu_get_message_name(smu, msg), index, param,
-				ret);
-			ret = -EIO;
-		}
-		goto out;
+	reg = __smu_cmn_poll_stat(smu);
+	if (reg == 0 || reg == 0xFC) {
+		res = __smu_cmn_reg2errno(smu, reg);
+		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+		goto Out;
  	}
-
+	__smu_cmn_send_msg(smu, (uint16_t) index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
+	if (res == -EREMOTEIO)
+		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This provides a centralized place for handling message error responses. 
We have been using this as a much useful log for finding the FW response 
code whenever a message fails (not just with undefined error code). We 
need to keep the same behavior for all the legacy code we already have. 
The side effect could be a number of such error logs whenever an I2C 
tool probes the bus, probably that is something we have to live with (or 
should be addressed differently).</pre>
    </blockquote>
    <br>
    That's already the case--see the &quot;right here&quot; above.<br>
    I've talked to the FW team about it--it may get changed in the
    future.<br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

The other thing is if we want caller to handle error appropriately, this 
really doesn't let the caller know exactly what happened. For ex: it 
uses EIO for a failed message and also when prerequisite is not met 
whereas FW defines two distinct error codes. Another such case is ETIME 
could be returned

1) While waiting for the FW to process the message without even sending 
the message
2) The same error could also be returned when the FW didn't give the 
response to the currently sent message.</pre>
    </blockquote>
    <br>
    Yes, and for this reason I talked to the FW team to split this into<br>
    execution status and execution result--that may one day come.<br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

Instead of making the caller to split into without_waiting/response 
sequence for every such message, it's easier for the caller to handle if 
we distinguish the error codes for both cases separately.</pre>
    </blockquote>
    <br>
    Note that this patch preserves the current interface and the current
    behaviour.<u><i><b><br>
        </b></i></u>What you're asking is extended behaviour which is
    another/follow-up patch.<br>
    We cannot add this here--it'll be asked to be broken up into a
    new/different/follow-up patch.<br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Lijo

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  	if (read_arg)
  		smu_cmn_read_arg(smu, read_arg);
-
-	ret = 0; /* 0 as driver return value */
-out:
+Out:
  	mutex_unlock(&amp;smu-&gt;message_lock);
-	return ret;
+	return res;
  }
  
  int smu_cmn_send_smc_msg(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 9add5f16ff562a..16993daa2ae042 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -27,7 +27,8 @@
  
  #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg, uint32_t param);
+				     uint16_t msg_index,
+				     uint32_t param);
  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
  				    enum smu_message_type msg,
  				    uint32_t param,

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--===============1648099473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1648099473==--
