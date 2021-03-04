Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD70C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA5664F60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5664F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3016B6EA5F;
	Thu,  4 Mar 2021 18:52:02 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D0C6EA5F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 18:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP6tqu3qkSi4XZwTGeVOdscbgn+3j01mk1VgGUOWpAz7G0MhuVfeBGqahVaxjn+JLOhplIJR+QJi+wqxTHF8vRWRqSnIHvkKvYnKczlafj6y2AxbWXW8yIFHFctvTpAG2aMHl9Ebk8n8i72cr1sat+HA+VE9JsibtbZ+3ruyKA7bTXEKBMLLM6Yf798rHPhTKk2zwAtnZkOtpKil0nKumVylSaX1ktOroezAvUzl9E/0kVs0tnK76Riajfo71fLe+miMgk/ai1F5X5OqR2LFUK09zfPr8bREG1WGM4SR37WbIjmAqLtb+O+HvkiUk6qheRnuTheiz6FHaGxMW+5MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPTrNlJmhNuh9CMiAoi3EONPJ+ojTcrVXrVDkYMeib8=;
 b=kRR75Vh9o33ZqLZtBztTnuVjQdAHgT/QHO4bJDBpNzQbkdWHESLAVMWQrogRyLrxXdq0R2YT/G9dhBHb8bTEG+7wKmgsILgG9uX0XGkqlyQLSl7vunqtrc8QcXVDvyuf2ndfoT16USW4HO0g/qjFDlnke0XmBDPSN+VovQ8sPOIoKXdaONUMxCt4GSHXX+Q1kTrQZ/fHHRNxCfzmh3gGlPWilryG9BTKes1NPKDTW1Ap3iLxa0pWE6quDgzZVtTpc/Uj4ANNilXUr1dLk2EM/O93a18ZPArbtwFDQkMfLj46ytdAY4UwfRBTPSTEgOGNUk8TlITLPgC68BQrLZOr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPTrNlJmhNuh9CMiAoi3EONPJ+ojTcrVXrVDkYMeib8=;
 b=wbuu89L3mozJbb0rJskki69lbKBE0v6RKwjjxLv7I090wPMMC9H4ZBbAGJWvnaXQl2npi06H1Ed/ZpAwwEvuCw+Q/clnX7p7xzSzmbvkj2BavahCZNizg5YZE5k3ZqNpZULR9X1tXORSPrY2gYGig6D/yXvX1/JbHjUPwqcXROY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) by
 DM6PR12MB3004.namprd12.prod.outlook.com (2603:10b6:5:11b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Thu, 4 Mar 2021 18:50:33 +0000
Received: from DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::2907:94a3:3013:bd33]) by DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::2907:94a3:3013:bd33%6]) with mapi id 15.20.3890.032; Thu, 4 Mar 2021
 18:50:33 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/display: don't assert in set backlight
 function
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210304174103.202272-1-alexander.deucher@amd.com>
 <20210304174103.202272-3-alexander.deucher@amd.com>
 <eeb3b2e8-affe-ffa9-b538-d0da4a34c877@amd.com>
 <CADnq5_NRF4N+85Rf-3xOq0nmOFjkwRbdj7znHsL9J2vN=Ufg5w@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <3239960c-d3a9-029f-efb7-e3fd14dde7f5@amd.com>
Date: Thu, 4 Mar 2021 13:50:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CADnq5_NRF4N+85Rf-3xOq0nmOFjkwRbdj7znHsL9J2vN=Ufg5w@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To DM6PR12MB3561.namprd12.prod.outlook.com
 (2603:10b6:5:3e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.19.251] (165.204.54.211) by
 YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Thu, 4 Mar 2021 18:50:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e9ad294-00db-4428-1c50-08d8df3e63b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3004F7791A7DABCD2344BA80EC979@DM6PR12MB3004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoOsWBVqg3ul9HdReJ8BnPkfhcsWt1ewDdJOGUAXfgL7SKZhNM9yeFp+D0HQl808wOdztPdonUmlq20EqdssshhV0GcbNWBzTboMyhMscN9hAKy91rIVuK+p3OrM84fyJVK1j5hBoE8PpMihfz8JkFDrx67OgYtWW19UkT8P/F4huEytWt1w/4KTbgRs6rJY5X1mYdF3QkZagpsVJ3Kn2UX3wuLWGWCvI0rt16GhEH+VH4nwf21ZriBm+K3GzvE+HaR+uLxsOWQROdVp23hBc94WPYDR8OEWX0ssUyeEbCRi8UfS1iy1CEBxAyMWmMxEPMk3E5elvbH4NQt9LB5QPpDyPfKtYfRK9kciqTx6IHn5PE5fEUekvrmO1DWImi4+XFxdXVpv55a89H13u1n+n+gU2eMwzDsZOXndPEmKMRrKFgZL2t5fT947Xaw8l+EmadWwos68/E1Unl3+W3SaQZNR1JXLAquc08ZxwySE3AoMy1+OdXpdAvdo5luW7nU8+O5gEG5GY+H0RRs9U3KT9DVm61HF/tPZLailBnkzncUfmq+ZUDn1QuxvgB6bwujKeYgKEOjGjqMFoMrgb87ruyzZLtZvpZoyr9HNR95/WcwkEBM5UpiclXmche8xGWrstju71a9n3rre6srb7JolAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(16526019)(2906002)(186003)(6916009)(478600001)(45080400002)(316002)(956004)(966005)(2616005)(66946007)(52116002)(5660300002)(83380400001)(66556008)(66476007)(31696002)(26005)(86362001)(6486002)(8676002)(8936002)(53546011)(36756003)(4326008)(54906003)(31686004)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NE5HWG1TMndybnJFZU1Rc3E3RDY0ZHNPRTNnTVJEQzgvbktESEk4L1ZiTXF4?=
 =?utf-8?B?ejZEWExxNkpFNk9vQXFOekxhS0VZdkphWE81c3hUM3p3cG9vekFIVGszZHpa?=
 =?utf-8?B?T1k4YmYxc00rSktIMG9aVmpOcGFMNDkyNGJ0SFVLOUN0WjVtbG1MK0wxN0hH?=
 =?utf-8?B?VjZJMmM1QlBDakR6MWJtZXluWTViUmRBdzlCZHJhUENRb2pUcXVGMVJCUVRM?=
 =?utf-8?B?Y1BSb3BzbVA3VEVIQkhocWhucndBNS9hYXE1UFV2RlJBRGNUVFBmbVhyaGVx?=
 =?utf-8?B?UnFlUDNTUXBSdElqMERxdHZRWUVlUjRZRGtrZ3VrckZ1VDA0OTIvWWVTMkdY?=
 =?utf-8?B?Q3BwV1AyRTBtWlRZYnlhUk5ubjhWRVJwRDliMjZPa2hjd0hVMWJPQUJFOUxr?=
 =?utf-8?B?MlJOTW9vZ3hxa3RxTE5taXdRZjJGdUZNK0doMTM0Qk5YNDJibDkzVksyMjVm?=
 =?utf-8?B?MDRTeUYvMVVaMFVFdmlwWkNuTC9uWUYvUkRrYjE1NW5ETi9uR3p6TU5KVDVl?=
 =?utf-8?B?ZE96MGhDaE1BTjZvUUtlTGk4VXZvRktjK2VUdG04RGxjV29SbDlVR1dKWHgw?=
 =?utf-8?B?cFY5Y1I3cm93cWJPOEcxSGpoSkJVSE5VbE5hb1ZsbUlCV25CSEJrQ2ZYNFBw?=
 =?utf-8?B?NkhNV2lmT3NHb25RQVpiNnNUbXhJako1TnZhR25SY1g4OFR6Vk1Hamt4MTUr?=
 =?utf-8?B?b3h1ZEdRamxrU1VkN3FuZTlrYTZoMVlRSVJzMDEvYmJ3VnE3dnp6R2hUTmY1?=
 =?utf-8?B?T2VvQVJOSzR3RXVDd3BtMFdxWWQ2Y2xESHF2Y28zUFJXMXFQdzNYNDQzazVN?=
 =?utf-8?B?N3p3OXlTWUxSSkpKOVF5Vkw5L1BmV2VSRTFUMnJTWG04Wlh1U1VuNFd2bHNH?=
 =?utf-8?B?WmhmejdVT3I3YjdLREdreTVDa3RXREpzcjl2S056amtqcW4wMWZWMHJRZFI0?=
 =?utf-8?B?VkxxU1VsT29MYm1sT2lVVjNwandmOThVUW9Pcmp4T0drcFhwSVVyTkp6bDE3?=
 =?utf-8?B?Y2hmWGtVNkxOMVpoUWI3OWhGeFRsaXdzTC9aakRVSVo0QUdWbWlYQ1FhUVlO?=
 =?utf-8?B?aW5la3lCSHpNSWUzaE1CZFR0bXg5d0JXdzVqb09ubmcyTUFHZTJhdlpqeGJw?=
 =?utf-8?B?R2kvWUtVNUUyRGlqczFKWlVqZmNZc0xVUDNvOHE5aCt0eWY5SGVmWjVEWURw?=
 =?utf-8?B?Tktja1BqNThVR2x6RzBzRWdlM2ZKcUh4ZmpOd0NCQ2tlSktRTFdFNSs0MTBh?=
 =?utf-8?B?RGc4NnVNZytwNGkrdVdsdlFYRDk1cmlQNzBNMzN4Q0hoMXpvWWFNajAyL3Ex?=
 =?utf-8?B?anRFYTVBMXpoYklYbjVNemhka0dxTGtmM3BmMnhtdmFPYW94LzN5b05ZUEpp?=
 =?utf-8?B?VU11TCtJYXNtMGVmZnFIT1BuUmE4VmdpQ1JqSDRyQWtXQ1JtUDlCR2dVVndM?=
 =?utf-8?B?MXlVUVFvQS9aTHpsaWVsUW1odDluaWFGYm81b0JEaFBBU2tWTDJMRjhMdWl5?=
 =?utf-8?B?TEE1djVPWkV3T243MUJrQkNDVE91K3FFazhRV1dCM0IwbDhxVEVHRlo1VzVz?=
 =?utf-8?B?MmY3NDQzV1hEanJweTUvMkhiMUd6NTdZUk9EYS9XMklPNEhjOHdQdEsvaFB3?=
 =?utf-8?B?N2dqTFp1WW41MG9Pc2c3MDdaMDBUZlZHZ2YyMkJnakhNQ1lIcERTeThJT2FT?=
 =?utf-8?B?TE5telUzeHhqNUhkTENDUHl0RkVCR1U3ZmYyaDFpbXdnMlpicmc1eDZLU3BQ?=
 =?utf-8?Q?OyFab+q1JviP/voxXqURR4a2WOTQ3kpCv2eTWiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9ad294-00db-4428-1c50-08d8df3e63b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 18:50:32.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdUyfLVWBvJN8JhcYOgiasgo8w2AjVbmrEfQrsZ4lxQEY8ZMD3T+/tAosaPf1UC6GMgABOOf9SAgy/Re4cu1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3004
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.de>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-04 1:41 p.m., Alex Deucher wrote:
> On Thu, Mar 4, 2021 at 1:33 PM Kazlauskas, Nicholas
> <nicholas.kazlauskas@amd.com> wrote:
>>
>> On 2021-03-04 12:41 p.m., Alex Deucher wrote:
>>> It just spams the logs.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> This series in general looks reasonable to me:
>> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>
>>> ---
>>>    drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>>> index fa9a62dc174b..974b70f21837 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>>> @@ -2614,7 +2614,6 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
>>>                        if (pipe_ctx->plane_state == NULL)
>>>                                frame_ramp = 0;
>>>                } else {
>>> -                     ASSERT(false);
>>
>> Just a comment on what's actually going on here with this warning:
>>
>> Technically we can't apply the backlight level without a plane_state in
>> the context but the panel is also off anyway.
>>
>> I think there might be a bug here when the panel turns on and we're not
>> applying values set when it was off but I don't think anyone's reported
>> this as an issue.
>>
>> I'm not entirely sure if the value gets cached and reapplied with the
>> correct value later, but it's something to keep in mind.
> 
> It doesn't.  I have additional patches here to cache it:
> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agd5f%2Flinux%2Flog%2F%3Fh%3Dbacklight_wip&amp;data=04%7C01%7Cnicholas.kazlauskas%40amd.com%7Cf259e9290b0e4ffbc87308d8df3d3121%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504801203988045%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4ROSclecKkfu2km3YeeM7sZK%2FP%2BcC8BajHSxJXQQCRw%3D&amp;reserved=0
> 
> Alex

That's aligned with my expectations then.

I can take a peek at the branch and help review the patches.

Regards,
Nicholas Kazlauskas

> 
>>
>> Regards,
>> Nicholas Kazlauskas
>>
>>>                        return false;
>>>                }
>>>
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnicholas.kazlauskas%40amd.com%7Cf259e9290b0e4ffbc87308d8df3d3121%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504801203988045%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BbwO5oOXuXFWD%2F8qNTygROj%2B9ZItRsXJb1U7ilcICh4%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
