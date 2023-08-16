Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CAAC001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 14:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3EF10E0FA;
	Wed, 16 Aug 2023 14:09:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35E210E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 14:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeLEGBq1cSvUV7eTpd+DYDxW6+0SV0rMPMwDMZsxrIDNdxBVcX+tPcCG8XpJZ2ndUDi497figcdiGrjed0QXwU2GH2VsyAgfknbgqTc7xuhJbw7g4xP7lnNeBNEjdCIpN1emERGhIin9b06dLHMKn1rEJcNfsl+pPl6bRRflWXE66pBNZT9UzFcVsqX5qHs8/YEg47TDHGNmK2uHHMuYHPfu2+2l85Vdggh5R+L/YX4CBVqlUR9/AZtPCyXJdkSxXB0bcVJt38oj3AWcyAsaafhyYrf2mof1FSpGF/zUNeRXapNCMNT80Y4wzCeJdbuWWXU3LALlCgopPNlkCibclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf9gKrEFF4xdTbB7fVir69ZEYc3M9bv+C/gppGuW1es=;
 b=g2AE1WWq/NFddZu8s7xW7BHAO8NUKSuABua7d2kTKGqe+Tu2mhPPT6Mb6z/Hw5SF6A0IfVFw6Uy9/om4dID19N7+2PE/HOV6kh7KQfiC2jqZFXd8semQ1aFH7voV86d88Co1uf+xw8Jjwdb5VtzRQQMdnJsOyjQbXC7lQsadcXH8nobT8quhF5xZXTsbFw3g6CCFDnZaeLV4x1B9lIq8zwZ+ptMn8rp147qOH3FJPTx+OVhOG9azQP8iZHSYP4rDfL+J7ebXqawz0qGK8wl9EWmQm9tgChV1nQogAt2JIv4IaS7ASBBbPp7hwxCVlTga5JWC71nrTEpEgOXCfq1Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf9gKrEFF4xdTbB7fVir69ZEYc3M9bv+C/gppGuW1es=;
 b=BZpLkPFg9NNGDUCaBFqbAgEn7mRMIF93QyFRJIiY1FxPvPaOw/9YjKY8IBGGGomJtEjhGivSdlwm8Zc55PY564Duz4cOwyzv6wN/dOy3wxgwbuEFVvjQjbfTfxquYnzZ/PwYfVcM5qGTWte0p5i/K9vQPShhns8so4gtxawQuNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 14:09:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 14:09:50 +0000
Message-ID: <8de6e9d8-9f95-f362-cd1d-b96c141f3f0b@amd.com>
Date: Wed, 16 Aug 2023 16:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/3] Fixup some coccicheck warnings
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, "Lazar, Lijo"
 <lijo.lazar@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
 <a959ad03-e5bb-404b-1aba-2d7c88b6a1d6@amd.com>
 <44715395-947a-4cc5-8971-a455dcc8c9fd@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <44715395-947a-4cc5-8971-a455dcc8c9fd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 535b87e6-0f67-49f5-2bcd-08db9e6274b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6VW0j0UrwLP4zTn8XwIh5OclqQpTAFO7y8LEsJqP5Rifvc8Dla56wC6UiQEz9c8ZaEhsdOhzVCh10YT3HsxzCnz98arT6/4ujwqRnQHn9OlaUWz921BGM2/l6P/mZCoCSe9Jgd4HwFG3+ZGAcLQYSdC4gWghj20hWUtbEVVuHYgeKKVyGkkXCY7jKG2XgbYYqgWM1UqwVoDOVkcBGLbKd0qT5Z1Rn317ftXi9lYgzDsAoaQ6x0C3a6ZQSOZegdyz/ClSgV1GMb/J1eTQS2p7OzZBcFEQS3wzLDLvIjj2bNVAad/pKb5Yzms7PvCEHllGGtLA5QIzCVQKhvwBxeHL7r8A0SMQJD7x3dfHevkqxluGGJQ6nkXlAkEbH1NKLvckguV5F6FX6frxToTllfGs/thY9Sj/cotbUyfvHm4U02TYiNNtlyRE9g4HNYRpcXalXg5LWeAfv57ILxcFsGFdhcmBQSl1vBPaNDppVaTx5zq+cJd7SvzOuhCfNcaz9UzLUEmGjU3Y/pzMpZlF4EPC+lii+rVTmJ8OAKXPorJYKSsujWwFPq9SLcdCaPaEpxkMaCEhs7f9zpZUDl2ZTjVub1kfrsB/my0J/9Yt9qMP+uCR5KB9hNYh5fGUCGIQbHmAhxloI19XkpQ5Q/+3yYyEsukN1Z8JD5J69M4qa3mOZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(921005)(6636002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1zVWJheDZXNHliOWs5NmtndGpnb25Tb0t1UVR0S2o0VXd1bGNXUDVZUnFt?=
 =?utf-8?B?b0Z3SldFVWMwYlFzRjdYL3c3KzQyV3plNUgyNExHK2I5QkdURC93VmRQVHdU?=
 =?utf-8?B?Rmh3QjB0amR6MXlqdHVDV2hJVnpJYUMyM011M1NFSVptQkZ0K2R0S3FxVUp6?=
 =?utf-8?B?Z1F5OE5qN1Jyb3h6OVRBdVR4KzlZZHBIaVpXcHpiNUpBNUxvRjdJSC9VVEdq?=
 =?utf-8?B?UW1XWkJpVGI2ZldkQUs5TUc3bStQMnBkMVpaUE5NYmlZV1p3dStuQmVYUmZi?=
 =?utf-8?B?OGZMSHUyR25DZk9mT0E3Yld0QXE0N1RRTjVkUFNBamsvVWZzcHR4aDJDdXM4?=
 =?utf-8?B?WWpZQTZEK1FTWnVjcms5L0ZVTTNmMERXMjIyc1Z0V2hkc1FJcDRUekpUeEs2?=
 =?utf-8?B?THlzc2ZLbllvWmwrcFZ0WXBVMHVEVFVMZVJ0L3dOa2MvSkY4djU4YXIrb2kr?=
 =?utf-8?B?RDBwMzg5YzY0WTBvcldUcE95N1dxZzlaUWdRYzkreWllZHg2U1VPUmgxVEtF?=
 =?utf-8?B?MzV1b1pNbWlRSnV2ZWlKK2dIOW90ZXR2VHRnWWdMcXVUWDhxdkc4cDNScHdM?=
 =?utf-8?B?bUN5c1Y0Smlxc05kU3VMd253MFBrVGVIWHZqb1RUbndKSjdGa2VZUGRhUXdJ?=
 =?utf-8?B?Y0xLMThCSU5QanNPQ1MvenJTdzVudy96ZHNtODZxbFJML25EOEtrMzFlb2dk?=
 =?utf-8?B?Zm1TWEJ5Mmk2bFFrejhjZ1NYU252MFFHK1lvVFFRYUkxb2pzbnU4RDNYZ0RP?=
 =?utf-8?B?SnYrNFNrd2JEZXd3bUpmSlhaMlBaZWREMjBiZXZ6UUVjVzQvbDNVbGRiRmVD?=
 =?utf-8?B?S0FUdldXVjF2TW1hajBFcm00NktuVUVmUXBFaHc2RjFJdWhybWJyYUorSnZq?=
 =?utf-8?B?MWNmWmx2bmhPdWRLRENSZk9VY2xKUVRhSmZYU0FUSTVwd3V1ZG52T3UzcjBl?=
 =?utf-8?B?ckJWb1hBOXErbEtkNFpjbWdJWU1iTis3bUZiSHd5RWR5Y21oSGxBUk9FZENl?=
 =?utf-8?B?RXlvRGRRdVNpS1R0OGl6Y0FkekRkRGZpdEhaem83T29PREluWEx5V0pjSU5w?=
 =?utf-8?B?OHFnUCtxVzBRWlM2WFZCeHVIT25zSVh3cEo1eXNpeU5oV2Q4RCt6aG0weDhW?=
 =?utf-8?B?UmVtTngxSXdOdDc2YjZsdzhIVzY5L2xZMXFIWDNZVFIwcFUreE1wQ0JKWEJO?=
 =?utf-8?B?ditEZ29hR1BtT1YwR1VaTHNMQkhsUFd2TE14N3RhaEZLL3BvclkwSGZRZExB?=
 =?utf-8?B?RGUxMllpKzRsYWp3Y1ErbEhqMFZlaUgranBBNGptOThBK09uVEx6cmFSZk5o?=
 =?utf-8?B?R251VnJQcGRFeVA1Z3R0YklBVTBqbkYyVlYxZmY5TnpMM0t5M2pwakFiamhs?=
 =?utf-8?B?QVQzNXJtc3RqdjZlbUg1d0pRNThJSWtweUJDdGtSYm9rbE0rczFBbkc3QVda?=
 =?utf-8?B?Z05BOFFlOXdjY21XdjdhZmVhQTFHdlFGWUNKbTczbHUrN0NPMU1ZU0FXblR2?=
 =?utf-8?B?NHl0NFFsT28rbFMwZE9HNWpkYjRVR0M1NnNDNTZWNVNobFpGUHhoeUZOQXZw?=
 =?utf-8?B?UUZqVVpaMGVoR2x6WnFXUDJ2d245dXlBcXg5d094bEdja3VqU1crNVR1cHYr?=
 =?utf-8?B?MGZLYUFHdUlmTGZpbW44TXFWTzQrVk1WbExDM1R5WWxHR3JxUFNqS1RPTnF4?=
 =?utf-8?B?YXNvNUExYWl5eUJad0dkdlRMalVLNUdTMXAraDluZnZJanpNMWlzUGFDOUxq?=
 =?utf-8?B?QzhtR3lzNTVXYnVBdHRGdC9nTy84cURlbFJGUnk3WjdwWXZDMnA4WkJVWExV?=
 =?utf-8?B?Q2RuMGwweXBmZ0ZwNEViNjV3bEZOclNkTmJROHppN3NYQmQvcjZnbXQzTW13?=
 =?utf-8?B?UkFITUVPNHJIbWpjeExjSVprYk80K2trZHpPbGxPL1ljT240SjlHRUtVV25N?=
 =?utf-8?B?WTZHcklGSmpUMGNveCtJRVcwbCtnQzNhVzAzZ2J2MU1Gb28xT080RmQ3dmVy?=
 =?utf-8?B?Z3RrbjJjckVINkZPcERuYkoxdi9XdkpqcDRFYVFoTFJSZmZKTFVSYnhUK1J1?=
 =?utf-8?B?YkY2cWVYbjBTNEZ2MzhacTh5ZldIbUY3bWp5SVB6RnFLeGpHNlJCTHhlQjVX?=
 =?utf-8?Q?mkP8hgt0Nf9tIl0R+2e2TgRBM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b87e6-0f67-49f5-2bcd-08db9e6274b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:09:50.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECWbqSiSMUPUCIut0pM86x5IhJ++NWUtHrSAOBRlseXpJPO1LkGmFHVuELDyjpMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.08.23 um 15:50 schrieb Harry Wentland:
> On 2023-08-16 09:15, Lazar, Lijo wrote:
>> This series decreases the readability of the code. Is it really a rule to fix such warnings or is it only a generic pointer to double check (not to be followed every time)?
>>
> I'm a little tired seeing these changes come in and agree. I see
> no value in this change. The old lines in the change actually
> have fewer characters and more whitespace, making them more
> readable.

For this specific the min()/max() changes I'm not a big fan of that either.

They are also not mandatory by the coding standard but just a 
recommendation coming from cocci I think.

Christian.

>
> Harry
>
>> Thanks,
>> Lijo
>>
>> On 8/16/2023 5:02 PM, Srinivasan Shanmugam wrote:
>>> v2:
>>>
>>> Updated to max_t/min_t along with commit title message
>>>
>>> Srinivasan Shanmugam (3):
>>>     drm/amd/display: Update ternary operator with min_t() in
>>>       'do_aquire_global_lock'
>>>     drm/amdgpu: Update ternary operator with max_t() in
>>>       'amdgpu_fence_wait_polling'
>>>     drm/amdgpu: Update ternary operator with min_t() in
>>>       'amdgpu_ras_eeprom_init'
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         | 2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 2 +-
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>

