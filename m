Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E357C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 21:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073D161374
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 21:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D161374
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E506E47A;
	Fri, 16 Jul 2021 21:24:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C295A6E47A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 21:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+JRvyepMirSGHT7kGWiSxoX9/37jzfDMx8+lI62Qb+DEaPYOwdSQOmbUVFgorz+gEt3rbpmR5uz1/rbZy7C/pQPOc4Dxof9Ey1DNwtlj61X+QpbU0pWCvNYTcrY1+vI/ho8C4bwUWkul60kJ3Lb4YPjYfZa3q1SFx7IbFWddWEYsKF+4QNg9nfo32Xmopcj//d/4h5SKUGJYaIH6OyIYqJZVVTFgQyDuXdQy9Rm9gKCTu4nvkugprb2OHFR40HmwrFwTaEWfZWG9sloPuoY7sp18El3/igWpwczQgFQ97gONgDY/IJoi4vGVzBnb5l5ek7jNxXl9Lpt6JypQJvMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nWru5KHhH715x0qQTSD0/nFGnz3no+iQeP4vWEO2Qc=;
 b=cMRyN0gH5e9i3gfjUU8C+sBbACmQbDTRjWVFZruC9XpHWy0REDsB72Gj+fMTLATzxXNl4/lbdMZteMPVRF9gqY0ue5zckrxKr9nIZpaDAhIdaONR8TSX+QPom3JNtwp1zaSoDG3apJwIT7lP5rEeverTfBgP+8o9Wp8jXG1EI4OOEjKp/tNyZDAaX80qqv4n5n5fpPD7b9+8m+XWQZ7/fmZd6k3qulUKkb57jK/2dHOVe7vIcBHu9ooy9iAwE0VC6JWhfAv62L6/4aR/y696a3W9YRwL7koOLsqJM7dlYZ9jyKU1f07aYKBP65OEsXC1L4HIbikJ2UzBGlN1rOov0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nWru5KHhH715x0qQTSD0/nFGnz3no+iQeP4vWEO2Qc=;
 b=S8ifpVsva51WXWDI5iEyZ1Lr9bd0tsy2qoIRBf4M74mtir+Tenje/TcUE0YaahWZ34xdwnocPGW0eNkerhc84mPErKpw3tUTycOoq9El0GOHR+1hSJIHcsvePUwF+yJWYufwTcwEgHqXbZd5CTyNwzCOsrNYQdZDKSj9nwq77os=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 21:24:33 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 21:24:33 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v3)
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210714175817.20473-1-luben.tuikov@amd.com>
 <CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <63cdaf97-09f9-afa5-e722-49c659e49dca@amd.com>
Date: Fri, 16 Jul 2021 17:24:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 21:24:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4f5132a-c000-4c6d-1356-08d948a01afd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0025F84C5099CDE1EC14BA8999119@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TckYdlH6AZb6n7Cx7zYCj+erX7j6PSjHtEDTBDEBw1WU7NYLPgNp2eZaBAnmr7PGAWzHGobYQTRsNkI+kJDocuSJ7RRnlrLwU2Jp+4fbvpURk1BIV8wLYva/+vMQrvsTRuoa3HOgQzi4xW/ecsFzJW6O3CLsyWsUWhrklLaFpxORKh41s30RT9CNZ0xjjs/MJNkSZ9mOtvteIIgextf7BgbVAHMmcu1TehmjrL0mhpEswK4kwzaENLlu7d8SC/baJf+ItxY1ouY4Bv81iA07vacoQ8bopBEOKGm4G0HlYB0CrCIIAnDa7xUbZpo8UbO5r7SSU6du+dm1k32qQV2kCXX5IIt95CfeBn3DqZqroG/jZhxIZ96TixmcTaEGmwM/rTMAfW/ksHdBw2kOLyIJ3KFElnZzly1OZpJ8y1/PKHPLVwSBoiVftoZdVI6e8gp1GWia7+iUDeBcZ1S9uLgPgVkOFm9K5FhetWVsUdCUgpWLy2VbGeNloPqiQ5VlRjKdQsutdeC44pA8sBBdr0iwDqfRjtsO22oFEitpxiPf0tPRaNM+oqjk/N86wFsM4PjVl4fMBKBOhJfS/q7dtfMeDH1VymYKbmlBpB8jSkLAYHamZaCRfvBJNBZoHUPEQbLYPRUkBkpDG3lCQm1qXMifE18uOBeXnOmsFl7cRXwQP/HjUtBmEQbp7JvOrtTdAjqs7FCsOx2CytSgkDQctEV1JNrtcXUlvk5nx1tXVQIizEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(45080400002)(66556008)(956004)(66946007)(478600001)(66476007)(30864003)(8676002)(8936002)(6506007)(55236004)(53546011)(54906003)(44832011)(36756003)(6512007)(31696002)(83380400001)(2616005)(316002)(26005)(38100700002)(5660300002)(186003)(31686004)(6916009)(4326008)(166002)(966005)(6486002)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhyYkVzaUxpcTM1aDR1QjNpVHREOTBQRWlKZ2lKcEdlMUtBWXNOcFA1cFcv?=
 =?utf-8?B?U2pBU2UweENCL3NhM2ZzVnRDM29XWDltQXNEbDhmSVR0UFpLS3hSc1RCalZ5?=
 =?utf-8?B?Y3lpTmNlT0FFUjhGcHBZYzVVUzdDY08xSDRSUWtadDZOUHZuQU9zZVlSaGJT?=
 =?utf-8?B?Z0ttWkJqZFVVTXpLMkp6a3FxV0RDdzJ5TnNnM0ZtaHYyK1EwOEJoWUlPdStV?=
 =?utf-8?B?ZnV6Z2ZDWmt2eGwybHhodk40YXE3c2Y1K2orMm4zL2R4QkZiY0VkdHVOajdp?=
 =?utf-8?B?OUg0ays4WFFoUXhZS0wwY3RoYVZtY0FKNzV6UkJLVlZ5ZnJlNmNMeFZrVE56?=
 =?utf-8?B?Y2hPY2tQZXRBcTM3VWJnMXZKd1lSS2g0V2ZWNzNDWlIyclJoaVljUzU1MVJn?=
 =?utf-8?B?d1hVamp5aldMSHdWMmFISktvMis2Nm5ma05EVm81dUZOMW5qVFNNQnN0dUUw?=
 =?utf-8?B?QkdkYVdXbHIxdHl4czQ5amFYZFByQW9Ob0ZaajVLUEFyTWoyNHk3Q0JwRjEw?=
 =?utf-8?B?Z3lpSUowdUxFZ0d1YW9Mb0xjT1p2bFFoU3BSU2o5NGFaMzNrazNxTTV5OWxv?=
 =?utf-8?B?NldMVlVDRFB6RWRNeFoxRU9PZGVMbVFHQWVTVVRDTkFSeGNOR2xrbWx5dnMz?=
 =?utf-8?B?RmdLZFRvZlhKRzRaWkFURjNPbSszSU1xRTE2cnZVSy9iLzBZalY2R29Zb21F?=
 =?utf-8?B?VXVrU1JaV0M1NTF2SHFZMFBZWG95Z2hUcDBJcStBaHhlckFzWkhEZG9hTW5i?=
 =?utf-8?B?cGFKVFhqQlFHc3BUQlA1dFl6bHV2OFFHVlppcWZkUDB5eEtMSXBjNHNNWXY5?=
 =?utf-8?B?djdsc0lLVWlzYkpnQkVwR2VxRGxIZ0M3eXFFdFd6dTZpVks1dFM2c1UrZG8z?=
 =?utf-8?B?UHZYRW5vK1NCSDVjK0JWdjVWNmhSbExjeExEMXZtTUhVbTNPM2drak02SFlm?=
 =?utf-8?B?WFpZbGk4bzVZaEdhdm0xYjJuTW5qSStGeUZRTCtxOGpCMnpXcENXaGZ3NXpX?=
 =?utf-8?B?cm9hYzIzdmV6Z3JDMEZla2dDcEYrMEhQcCt6cUpLSm1pVUxYTjB1eDF0TzYy?=
 =?utf-8?B?dkN2VHU0MHlYc1BiT3Z0Y3BSY3ZxSzMzbEVVNkY4R0JQS2VMR2hsRjdGeVZ1?=
 =?utf-8?B?K3BCbmUvSUxxTjF5QzdlMXNEMEZlM1M1K0ZFdlR3VWd3L2xOS1BhaElIODRj?=
 =?utf-8?B?QnBaRWIveENoM3ZucGZEVlk4cWVPc1JvQS8yYjVjVUFUKytmK3puMHdPRzhm?=
 =?utf-8?B?UlNpN2lJSlV5dXJFQUlCUDhvbHd4aktUd0x1WVFPb1o5NWZ6dFZ2QkFMMkJJ?=
 =?utf-8?B?a0RpbktxZEgrZGErd0NiMTZQVWlWSm9IVWgzTGl4NXNCbUZoNCtLRlRDUXN4?=
 =?utf-8?B?QmQyZnIvbFQxdG5OeGg2dEN5OWd3ajNmMGVHTG9sYjAybjRmWElqZmFXNFFp?=
 =?utf-8?B?VEs2NXFTWUZCd0EyaHUrMFRmRnBIL29PZ1BHYmQ2OGRrZ3Q1cEc4aWhpbVJ6?=
 =?utf-8?B?VGZqL1RpVXBOcFE1OFEzWTZXOWVPb25BdzMxYzk3K0xxTkpDc1lNZ1hFRDhU?=
 =?utf-8?B?VWdHRHRJSVk4bm1IR0c0Z2dDYzJxbTg3T29HSTV3K0x4UDNwSzJYK0dWcE82?=
 =?utf-8?B?VlpMa1YwRHpUdVFkMDFlbzZQUi9PSjN4WGRoK240MjA3bFNYVkNEMUJBTVhr?=
 =?utf-8?B?a1dMUEJaY2EwYm1xMGVSTmR1bjRIMUVjdFZ4eUpocDNEOG54MjVnc3NRN1VQ?=
 =?utf-8?Q?x9NHqobfZRbSCDQwV8WjfAdkKnssN/dH97T7YwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f5132a-c000-4c6d-1356-08d948a01afd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 21:24:33.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4LBikcg7ndWO9SoD3iinZ1DHV6ysq60MRp6sT8f35fgwNoW4IV3VaSfeAOSFAUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Evan Quan <evan.quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1601568686=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1601568686==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2021-07-16 4:29 p.m., Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Jul 14, 2021 at 1:58 PM Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This fixes a bug which if we probe a non-existing
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
 #define __SMU_DUMMY_MAP(type)  #type
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
+ * 0xFF, execution status: success, execution result: failure;
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
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Might be nice to add generic SMU defines for these just to help code
readability.</pre>
    </blockquote>
    <br>
    I can add the macros of these constants then. The reason I didn't is
    that I didn't want<br>
    to define those yet again.<br>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">While reviewing the patch, I kept having to refer back
to the comment to remember what the error codes meant.  Other than
that, this looks pretty good to me.  I'm trying to decide if we should
do some limited retries in the send_msg function itself if the SMU
returns -EBUSY or if we should just leave that up to the callers.</pre>
    </blockquote>
    <br>
    We should either increase the timeout we wait for response, or leave
    it up to<br>
    the caller to decide if they want to retry based on whether it is
    -EBUSY or -ETIMEOUT,<br>
    or whatever it is to their needs.<br>
    <br>
    In detail, the function smu_cmn_send_msg_without_waiting() doesn't
    wait for<br>
    a response of the execution of the SMU function which was sent, but
    it does do <br>
    a wait-check before it sends the function--if it is 0 or 0xFC, then
    we know<br>
    that the SMU is busy and we cannot send the command.<br>
    <br>
    Clients can use the function smu_cmn_wait_for_response() to wait for
    a response<br>
    once they send a function for execution with
    smu_cmn_send_message_without_waiting().<br>
    <br>
    OTOH, the function smu_cmn_send_smc_msg_with_param() and its
    derivatives,<br>
    <i>will</i> wait for execution status, after the function was sent
    for execution to the SMU,<br>
    and it also does the wait-check mentioned above, which is abstracted
    into its own<br>
    function now, namely __smu_cmn_poll_stat().<br>
    <br>
    So if the SMU is busy before we send the command, we wait a generous
    time, and<br>
    then we give the result to the caller, so they can decide what to
    do.<br>
    <br>
    Either way we have it covered, so not much action here.<br>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
Would be good to get some feedback from Evan and Lijo too as they know
this code better than I do.</pre>
    </blockquote>
    <br>
    I spoke much with Lijo already, and Evan chimed in in v1 of the
    patch.<br>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

I presume you have a patch for i2c to handle the -EIO case when
probing a non-existent i2c device? Or is that already handled?</pre>
    </blockquote>
    <br>
    That's already handled. The -EIO bubbles up to user space. I'm
    actually running<br>
    with this kernel right now and all is working well.<br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 {
        struct amdgpu_device *adev = smu-&gt;adev;
-       uint32_t cur_value, i, timeout = adev-&gt;usec_timeout * 20;
+       int timeout = adev-&gt;usec_timeout * 20;
+       u32 reg;

-       for (i = 0; i &lt; timeout; i++) {
-               cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-               if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) != 0)
-                       return cur_value;
+       for ( ; timeout &gt; 0; timeout--) {
+               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+               if ((reg &amp; MP1_C2PMSG_90__CONTENT_MASK) != 0)
+                       break;

                udelay(1);
        }

-       /* timeout means wrong logic */
-       if (i == timeout)
-               return -ETIME;
-
-       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+       return reg;
 }

-int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-                                    uint16_t msg, uint32_t param)
+static void __smu_cmn_reg_print_error(struct smu_context *smu,
+                                     u32 reg_c2pmsg_90,
+                                     int msg_index,
+                                     u32 param,
+                                     enum smu_message_type msg)
 {
        struct amdgpu_device *adev = smu-&gt;adev;
-       int ret;
+       const char *message = smu_get_message_name(smu, msg);

-       ret = smu_cmn_wait_for_response(smu);
-       if (ret != 0x1) {
-               dev_err(adev-&gt;dev, &quot;Msg issuing pre-check failed(0x%x) and &quot;
-                      &quot;SMU may be not in the right state!\n&quot;, ret);
-               if (ret != -ETIME)
-                       ret = -EIO;
-               return ret;
+       switch (reg_c2pmsg_90) {
+       case 0:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: I'm not done with your previous command!&quot;);
+               break;
+       case 1:
+               /* The SMU executed the command. It completed with a
+                * successful result.
+                */
+               break;
+       case 0xFF:
+               /* The SMU executed the command. It completed with a
+                * unsuccessful result.
+                */
+               break;
+       case 0xFE:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: unknown command: index:%d param:0x%08X message:%s&quot;,
+                                   msg_index, param, message);
+               break;
+       case 0xFD:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s&quot;,
+                                   msg_index, param, message);
+               break;
+       case 0xFC:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: I'm very busy for your command: index:%d param:0x%08X message:%s&quot;,
+                                   msg_index, param, message);
+               break;
+       case 0xFB:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: I'm debugging!&quot;);
+               break;
+       default:
+               dev_err_ratelimited(adev-&gt;dev,
+                                   &quot;SMU: response:0x%08X for index:%d param:0x%08X message:%s?&quot;,
+                                   reg_c2pmsg_90, msg_index, param, message);
+               break;
+       }
+}
+
+static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
+{
+       int res;
+
+       switch (reg_c2pmsg_90) {
+       case 0:
+               /* The SMU is busy--still executing your command.
+                */
+               res = -ETIME;
+               break;
+       case 1:
+               res = 0;
+               break;
+       case 0xFF:
+               /* Command completed successfully, but the command
+                * status was failure.
+                */
+               res = -EIO;
+               break;
+       case 0xFE:
+               /* Unknown command--ignored by the SMU.
+                */
+               res = -EOPNOTSUPP;
+               break;
+       case 0xFD:
+               /* Valid command--bad prerequisites.
+                */
+               res = -EIO;
+               break;
+       case 0xFC:
+               /* The SMU is busy with other commands. The client
+                * should retry in 10 us.
+                */
+               res = -EBUSY;
+               break;
+       case 0xFB:
+               /* Debug message.
+                */
+               res = -EIO;
+               break;
+       default:
+               /* Unknown result from the SMU.
+                */
+               res = -EREMOTEIO;
+               break;
        }

+       return res;
+}
+
+static void __smu_cmn_send_msg(struct smu_context *smu,
+                              u16 msg,
+                              u32 param)
+{
+       struct amdgpu_device *adev = smu-&gt;adev;
+
        WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
        WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
        WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+}

-       return 0;
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
+                                    uint16_t msg_index,
+                                    uint32_t param)
+{
+       u32 reg;
+       int res;
+
+       if (smu-&gt;adev-&gt;in_pci_err_recovery)
+               return 0;
+
+       mutex_lock(&amp;smu-&gt;message_lock);
+       reg = __smu_cmn_poll_stat(smu);
+       if (reg == 0 || reg == 0xFC) {
+               res = __smu_cmn_reg2errno(smu, reg);
+               goto Out;
+       }
+       __smu_cmn_send_msg(smu, msg_index, param);
+       res = 0;
+Out:
+       mutex_unlock(&amp;smu-&gt;message_lock);
+       return res;
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
+       u32 reg;
+
+       reg = __smu_cmn_poll_stat(smu);
+       return __smu_cmn_reg2errno(smu, reg);
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
-       struct amdgpu_device *adev = smu-&gt;adev;
-       int ret = 0, index = 0;
+       int res, index;
+       u32 reg;

        if (smu-&gt;adev-&gt;in_pci_err_recovery)
                return 0;
@@ -136,31 +327,22 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
                return index == -EACCES ? 0 : index;

        mutex_lock(&amp;smu-&gt;message_lock);
-       ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
-       if (ret)
-               goto out;
-
-       ret = smu_cmn_wait_for_response(smu);
-       if (ret != 0x1) {
-               if (ret == -ETIME) {
-                       dev_err(adev-&gt;dev, &quot;message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n&quot;,
-                               smu_get_message_name(smu, msg), index, param);
-               } else {
-                       dev_err(adev-&gt;dev, &quot;failed send message: %15s (%d) \tparam: 0x%08x response %#x\n&quot;,
-                               smu_get_message_name(smu, msg), index, param,
-                               ret);
-                       ret = -EIO;
-               }
-               goto out;
+       reg = __smu_cmn_poll_stat(smu);
+       if (reg == 0 || reg == 0xFC) {
+               res = __smu_cmn_reg2errno(smu, reg);
+               __smu_cmn_reg_print_error(smu, reg, index, param, msg);
+               goto Out;
        }
-
+       __smu_cmn_send_msg(smu, (uint16_t) index, param);
+       reg = __smu_cmn_poll_stat(smu);
+       res = __smu_cmn_reg2errno(smu, reg);
+       if (res == -EREMOTEIO)
+               __smu_cmn_reg_print_error(smu, reg, index, param, msg);
        if (read_arg)
                smu_cmn_read_arg(smu, read_arg);
-
-       ret = 0; /* 0 as driver return value */
-out:
+Out:
        mutex_unlock(&amp;smu-&gt;message_lock);
-       return ret;
+       return res;
 }

 int smu_cmn_send_smc_msg(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 9add5f16ff562a..16993daa2ae042 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -27,7 +27,8 @@

 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-                                    uint16_t msg, uint32_t param);
+                                    uint16_t msg_index,
+                                    uint32_t param);
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
                                    enum smu_message_type msg,
                                    uint32_t param,
--
2.32.0

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C8cabc5abc13f4a7eec9908d948986f87%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637620641810528386%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=LZnpMxMFjUgXVrrQNTGPja8sQFPXtZG6Z5mOuKog8PY%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C8cabc5abc13f4a7eec9908d948986f87%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637620641810528386%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=LZnpMxMFjUgXVrrQNTGPja8sQFPXtZG6Z5mOuKog8PY%3D&amp;amp;reserved=0</a>
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--===============1601568686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1601568686==--
