Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3EF206E7
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2CPxmlhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3EF206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C3989C3B;
	Mon, 27 Jul 2020 15:45:55 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CA789C3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 15:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmJHtRGN1/n7kkaw1IST6+WRtfpFhD4Z3My9qz0DsRdyyGHFKY3bQbR79lfvSStBW5KDxHkEWdCNxdIqwjisHGUzCP/15vmDHT2Y6CnBvGPCm9KmCKUK5p4XoI3Wumif+H2fJsT6W6xuYXgaryzryrkqyJMtjM//FXcK8UetJXOVuZCJQpbo0AO1Bkdulcpt/dnmUY8F6tFASEgQjwiWFM6hRr2dKyznUHPsYRCvy4r73xFRLKISRB8HAUND9Yt6q70ilcxiYZTz17jTq9WjPtaDmd7B2FZp+eRgva/Ghr8Iw1zOpWJq9qix7v0370Q+Ubh7cLb8/PVyET9XVzLCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP2B7QR9GNpw2NMlgWHbnQHjFOWh7MTBa0yywKsJzRU=;
 b=KrQR0flBPsaCF+NDtzN+sR1oaoK+QqedTKZmXKXboscLZ9QcH72z9MZLBXihImeWfpeuA1YgjTWtzxiEaYdmb5Fw7HzA545nH8B+lS2YsqZYa9QnHQxURH8GLI5EEfDn+BcfragGk2pPalt6YLkktuYnd3DsTqezP6yW8hk6weHPbf/vv7Ker5236jLxphqilnk5GZEE9nawR7JX0WX16ABvHs5y7ZFeIJ2v9+gAUtvYLp/RMsolCYkn4+KrOyp0gPm97B39gmTpgUrmsr5ej7sojig0fUoKxe6VYV4j6ySrJSB5sr3DXDpCw+Gmxu67Fl+MImnfTxpzgdeI68QL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP2B7QR9GNpw2NMlgWHbnQHjFOWh7MTBa0yywKsJzRU=;
 b=2CPxmlheLiGPYCUeqkMlf0S2AbcGjM13TAta8Ih+M4MQOuCND+B8uBPltQWAVwhU2wlAxK5Z49BglsVWT7ivHSMCtYzR2RnZukhfClIc8IF78xLCcDVrk91wem4osyDWK2yYJIGy2qHGGWR36xsspci76fmLNddhLYXtAxl3eJY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) by
 DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 27 Jul 2020 15:45:54 +0000
Received: from DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::6df0:61cb:d37:2a0b]) by DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::6df0:61cb:d37:2a0b%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 15:45:54 +0000
Subject: Re: [PATCH] drm/amd/display: Use proper abm/backlight functions for
 DCN3
To: Alex Deucher <alexdeucher@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20200727152204.12523-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_O=1RPvx0b++rHNgn1ibY2buqBtU+m8eADC3CnUZBLypw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <dbee5b43-ebf1-b4b7-0a6f-a663f29cb09f@amd.com>
Date: Mon, 27 Jul 2020 11:45:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_O=1RPvx0b++rHNgn1ibY2buqBtU+m8eADC3CnUZBLypw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM6PR12MB3561.namprd12.prod.outlook.com
 (2603:10b6:5:3e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 15:45:53 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41783023-0218-4acc-dfc2-08d832442573
X-MS-TrafficTypeDiagnostic: DM6PR12MB2905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2905AC2BA2D3943E35CBEE5DEC720@DM6PR12MB2905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3df/8Tt6gHMwZRbCoCWwHJrTAF7+KERYk3Cr6378k3V58OAuMeT30JkV8JWpiC1jNFXuPQ6paXVr9sSZvjdOWZfbLd/+0wIUryiy6m55AsPy2aLGDLOGzAe8GGiesOfL1GsFUjuN0eNNNHTflXe+nEao1wHVivSaI2J4BrTWF3ne/2eVqVFWmaGKJfagU6X3r3iofqkJ8KCcWH6ugNDTlCkxg7mPHqlccbwdjAMeMLcwR7g15u8kmjaBGkGQVs5OKJ/qDdj4kcyTR5/ypgKTGGFR4xe2RYgfhn+V7Nz+bSKbJ9cNDPGTCsg4nAA5Yr6CrdWokAIGvenOYy4MvULOrtJ7wdLS6NMJ60lZswrjTQIoTDNPz2F+G6nCC6gh+RddubgVNXujbUdPPhdpvtJbjs0gDqgzfArYYadTDWiFmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(6486002)(186003)(66476007)(16526019)(8936002)(52116002)(53546011)(8676002)(36756003)(66946007)(966005)(31696002)(478600001)(86362001)(66556008)(6636002)(31686004)(26005)(4326008)(110136005)(83380400001)(316002)(2906002)(54906003)(5660300002)(16576012)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p3DQusBuU9RpMYUobwi9M0Tzm/ueg358W5OUjFtENp9eBl/be0TRHY1fPAO+9RRygEjnKU6bCDXqoVeuRttTj1Ihvw8FGuEse2n1mL/su7q0bMdMeYhebUmjJbDYZeMKEDf1bJrKv9xUG5kZHTqGvWKynU9Kmd+3Aqtwd7HFZiOV2LnN9wB0AMq3BeJYHD3uaKe9JQ/ccEcGNPcwKxmr90sye4cfFa1yVmxF2RNj4L23T4rQSgQ9NpN4lEWy7wCBdYSBPV+tanQvpwCn+0TAf+gVNGeRoVhLfQBp71r4xQaVVz70tRrKKC3gIfFO0OK3VKCFbahqWCwBOsUht/t6DeicMQgVlRqQim1WXEsMt16TyVum5P8XqGaE/LbUgOdnEXAx0QuTI8EuKv3vwAul+1hAGiKbtrcUzIfA6r55PJrKffBEZEryNM1t7GTy1y7noU/jaOLv+ko6NAJHWquC22CfM0Nc1mU0+CNlgrf3qk0hEYgJJYP2L1+wHKC7UmyV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41783023-0218-4acc-dfc2-08d832442573
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:45:54.1910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pijU58Xh2bawQ460YhlOXceF56ERFgeV5jWoj3xYLMpT+DKghQ3bwCjoxeRXO5wfluJLRzO8Wqj7Y8fRGjwWoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-27 11:23 a.m., Alex Deucher wrote:
> On Mon, Jul 27, 2020 at 11:22 AM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>>
>> Use DCN21 functions instead of DCE110
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> index 1b354c219d0a..9afee7160490 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> @@ -26,6 +26,7 @@
>>   #include "dce110/dce110_hw_sequencer.h"
>>   #include "dcn10/dcn10_hw_sequencer.h"
>>   #include "dcn20/dcn20_hwseq.h"
>> +#include "dcn21/dcn21_hwseq.h"
>>   #include "dcn30_hwseq.h"
>>
>>   static const struct hw_sequencer_funcs dcn30_funcs = {
>> @@ -87,8 +88,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>>          .set_flip_control_gsl = dcn20_set_flip_control_gsl,
>>          .get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>>          .apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
>> -       .set_backlight_level = dce110_set_backlight_level,
>> -       .set_abm_immediate_disable = dce110_set_abm_immediate_disable,
>> +       .set_backlight_level = dcn21_set_backlight_level,
>> +       .set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>>   };
>>
>>   static const struct hwseq_private_funcs dcn30_private_funcs = {
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
