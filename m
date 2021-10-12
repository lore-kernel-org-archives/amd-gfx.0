Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3032C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB118610A4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB118610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B9D89DE5;
	Tue, 12 Oct 2021 20:57:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706B289DE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 20:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrH6pWwRQ9NNHfoSaOZmTn/1j23pH52f9gIgRYjCteJOzfiHu3ABprzeafSByvJWJB3i7lNocoGcrwetpE5k3k4cmszqOupe4t6k9wNNhTtIkja9gkxgwDCpn1Avyu5mpnTjEctG0gIko0XVzQy7uCR8YuxbEr/e8Mn9Uqcuc8cNJmmhegINhDsU4EtudjxH4Qai/zOikG3flNpKSyNiA1oPtz0UfpZl9Mt2AdA7kJ/P8qyxOqDP0f6O5MMa2J9Z++y/maiWkZvdpDZ9xEF+wAMsSGi/xx820GBlHjfDET+9xc9PufgNt7qwjpm6XHViGlttaRHbxp0OT7pJsFXJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkaisZ2gctwg6jEP/mAO/18C1eGcRhT+5BK2OF72m5g=;
 b=P89VFjtf0OD3vkcCqVpVgZd7VWm66iViQw/bZcfDPQJoGmhuKUqpvjbns6Hzgmx2mKFLDTheFc6ZV3IyQq9AU5OJaqMbsMHthOH+3Z3LjEDlL4Q5/KjpMbhkED994rGlMwhbebcQ3rpBu/bxY2FTzH9WyK7+ayrgaNZzWKmnOgTzwL2GOoujd7ZkYYRO/u/+1un4zhnIi6SMOj0342xAzwaclTtyGjBB9uNFRB7qLR6zRHLqGPwfTdwEfLjd6rnIrV4VTQnpj4w6No8AONHYmcNYnbnX01dkWYyxBNvpBvQ/zWQYjNNtwkMdgdpxFwyQSjLsBwjWVORRq+sjVqSZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkaisZ2gctwg6jEP/mAO/18C1eGcRhT+5BK2OF72m5g=;
 b=fm6y11HJqUAZ7KC9WssOEZPZb8HBypyhNJZ5IMa24ATLcBthi805Fr9jIC7clFFRQRFUBPKXMLEAeMYUO0fUs9ykvCdZu4jzREAaL60WZJqHFyU4/gjZG8FoPUNi2CLs9icGGbvco6TNbu3dxq11RT7ttW+1kMMm9XreXPyeUfI=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 20:57:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 20:57:42 +0000
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>
References: <20211011151609.452132-1-contact@emersion.fr>
 <44154452-aa21-3f08-ffe8-e68fb8036271@amd.com>
 <CADnq5_M-13Sf1g4cw0Qt=qps72GEweZM-SrhQ9obLRsVr8_zfQ@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <f7f76c65-8e7e-67fc-414b-761702a97fe3@amd.com>
Date: Tue, 12 Oct 2021 16:57:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CADnq5_M-13Sf1g4cw0Qt=qps72GEweZM-SrhQ9obLRsVr8_zfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::33) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [100.115.92.195] (198.200.67.104) by
 YQXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 20:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a23c25-02aa-4104-39f4-08d98dc2eeee
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5394DB0F41FC01C2DE89D17D8CB69@CO6PR12MB5394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBCvsPTBoxs27xzTeWHJOXg02XkZI4nW7ZvAkiKhXd3KjS4wAS/lXswLwJQT9k19PbW2dta7Gp/D3rHWOeBFkqUruxoSnbvwOIS/2YXgVgXKaj9hxCMkmijrThTQXHN4g+40DBl+LVUZpGw/szG5WXrOkdvcgtMpC9UiQmG3UFLDJBujIAaE9PBT87JyLMgU2UDVujg7eWHlDAAsOsf9mzjIVAkchPHVO8yb4nXghFU/kja+lRdSECqTnUZfT0OiRzc4zUwIpFzWkgbiY9HNFynOe7846GPYOtm2RJiQW+ZnZhtAKLlMAfT/LUzz+LwOby5guWOUm+czzqLiJ8jpY5bbSQq3XD7/rBlGJfQA2q5G+ndPCB5A2oUL6OZbV9hGVfbvrFFP5C9aKS+jkeLJ/AGIOedc1YelSuhd+D88Ipe4642uj6yW6BZfSJgk7eidJt9SYtvjVzJ/xL81T/fk5EjC35dqEtAqEzhIBVG5d+xWvxX8vD/n1mVKJ8AIcwh8tkG3OR/Dhbeii89fI7PAfb3uu6DdKmXMA+nHGwZfPAA36pyb0jpNcQjXvQtjDlIQDzWz5wNgb6QuyQA2p4RLMBv19hNSUr0JTlYdB8oOObXb8/kzZSpSDTtzFRxOKCnxikTlXthWxy5qp8hzLN7QftB3bTUS65kEPkhAD9UJDITGdsDa2jhK4yUHZG0TmSWzgccJQzne8WqZGNBUHXY1iy8RcQnfgiyM77dieMaIIpTdYXhdX4Pb56fTAaEuV8LF78KUUNfhHeAZyEGbhJ/knSieJasu5OGdinuGKs8Rx5AOvcp5Sh9mr2htV7mGBedjy4I+gF+/7SiAWF0lLSw2PG0YXYG656QEH/P40pPcnm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(53546011)(66556008)(6916009)(966005)(26005)(6706004)(186003)(83380400001)(38100700002)(45080400002)(54906003)(316002)(86362001)(31686004)(16576012)(44832011)(36756003)(8676002)(66476007)(2616005)(508600001)(4326008)(31696002)(5660300002)(6486002)(66946007)(956004)(8936002)(4001150100001)(6666004)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9XZ3FocS9SVDF4WXYwT2QvdTQxWG5BMXcxSmVDaTZYOGlWdFd5ZnM0WmFH?=
 =?utf-8?B?cXhKMlM2MVBkTSt0TmVYODVJZEpjUWlhRmhaK3pUK1F6bGRvYjNXWHZITEJL?=
 =?utf-8?B?aGlZakpickpCMHlwRGNTQlE2WnRoZytiaFpaMlc3L3ZGeXh1MWRybG5iNEpJ?=
 =?utf-8?B?OEVaMjJUQ01TOWJxUEtNYTRleExsM0FlcGp4MzZNWE9NbzRMQ1N3MkRja2R0?=
 =?utf-8?B?RkxnSDYxNlhwcDVzcVFkaDM4VWhxWGkwaGk2a3hlVXdGa1V3WkIwd3FMMStN?=
 =?utf-8?B?RG4vY28vQmlXbGRZV1ArVWZjcjdxTVM4Wm5IMkcyUXNxNzVyUXRBT3VEZklq?=
 =?utf-8?B?OUNYS2xzUGdsME9HZ0U3OEtMTEdQdXhvZFB3L0FoRzAvLzRxeXl0UjVFVXV3?=
 =?utf-8?B?OVZPZTlzWnZCWitVQ3lQM2pSS0VHSmhUWlJUTVJTY1paOURzTkxEUXQ0aGEw?=
 =?utf-8?B?enY3OXBKUlNnZzdScTBYTThxMkRKZU5mZHdVTGcrd2RKWTlDcElZTkJsajVO?=
 =?utf-8?B?SlVlMkEwb0c2M3dMN1JNRElWZk1zcWExSEdKNHF1K3VNT3d6VXA3MGpnRzRz?=
 =?utf-8?B?d1plNXJSa3g3dk1BYXZobTBNK0dQTmNPRCsraTdqeHY5V2RreWZZZXVMQUxZ?=
 =?utf-8?B?MktxNEVoM1JZL3dMYWRlL25GbVFub2k5ZmpoRCtvVVMwMjQ2dHlRUjZ1Q01n?=
 =?utf-8?B?S2VqTjRGK2libHZ3amdXeXd5dzRPWk5LSFhaSnJzQ2VzWFBtbSs4OE8yRU5L?=
 =?utf-8?B?b2lkcmFNVWlzaUtlclJLdVR1c1p5RWwvV1Q2Nk9PcXFDaTdoL1orNmllOWRQ?=
 =?utf-8?B?eWlyY1JLSGU1bHQvRzN1QWtkNlFHUXV3S0RYY3Y2cW5xL3VlL2pPQk9BU0Rm?=
 =?utf-8?B?WXpvV1ZWWm9XbFM0Yk9lY0FzaTZreWd1MXl5d09XcVNBOVNhUDhOZFdIdWpP?=
 =?utf-8?B?ZTFNSVVZWm9nS0RxMzhZRVFSUzlQK01zYlk2a1BKa2kxcXJ1TUdhNzdXcHNF?=
 =?utf-8?B?ZlZEYVJjVjVndnBlV3F6K2FDMktJRVdpUlpkemRyV3Z4aWd4RlU1WFZxNmtm?=
 =?utf-8?B?VVpUSC9OcFFncHNYY1lvQjVaaE1pUDN5a2R2eDdvVkc4aHFvZ2pKbWlHS28v?=
 =?utf-8?B?eVdDRlk4cDV4di9JaVNydFp6Z3prTFhQdWw5Q0xjNlA4Njl5SHlrWEFVeFNF?=
 =?utf-8?B?S0QxdEg1bG9PU21uVzdNTkNLYlVqRUk5UkpzZXVKYXNRcW4yc2hMck4rYlU4?=
 =?utf-8?B?KzFKT1NBeXFMaG1WS3c5cWVua2I2OEhZZHdHb1RQN1BRUW5tTFMrUlFFenpG?=
 =?utf-8?B?QllveGgwRjNNelhwTHA2SHp6TDZkcmJrMzdYTDI1YXdLTDBPSWQyV1JRQm1G?=
 =?utf-8?B?NTd0ZlhjZXNxZ1hFMnlBWmI1c2RsZ1pMb1hlR2Y2N2FIY0Y1QW8wc3pMMU1z?=
 =?utf-8?B?TmpNNmkxSTZZRUZJUUt0Y3pNRS96b0N3Wjg3dXVOczd4aERlYUpyRkRxRlhH?=
 =?utf-8?B?K3JzU3JlV0xjaHg0bFUvdnY0VGk2VXM5c1V4NjdQTk04VDU0OHV0QjVzVnhz?=
 =?utf-8?B?dk5VRDFRbWgrdWlyVTcrT1BLWDl6OFNPZm8rSUZUSHRCWnM4eVM4YmJDeVVv?=
 =?utf-8?B?UXhMWlpXMnE5TVpVSFdkL2ZsVk51aGc2dUx6cjdxQlQyaEpobGFjVzdCMm1z?=
 =?utf-8?B?dEkvU1FIVXJYM1VxT2lka3R3Q0MxY1dnekwyUzJncC9HM2M1VVU3N2FUdVk2?=
 =?utf-8?Q?D9gTQKQ3Dyw+5yMt9WtRxIoz14EK6XCHizCtWxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a23c25-02aa-4104-39f4-08d98dc2eeee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 20:57:42.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKUyjKWZ9CsxCgCfaWcXg0FINkWB4iQKm4VrMvumHxDAfwFLSUhilnty5qtnRLVZzTGhutN/J5tbpm3dh4X4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/12/21 3:57 PM, Alex Deucher wrote:
> On Tue, Oct 12, 2021 at 10:39 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2021-10-11 11:16, Simon Ser wrote:
>>> Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when
>>> using overlay") changed the atomic validation code to forbid the
>>> overlay plane from being used if it doesn't cover the whole CRTC. The
>>> motivation is that ChromeOS uses the atomic API for everything except
>>> the cursor plane (which uses the legacy API). Thus amdgpu must always
>>> be prepared to enable/disable/move the cursor plane at any time without
>>> failing (or else ChromeOS will trip over).
>>>
>>> As discussed in [1], there's no reason why the ChromeOS limitation
>>> should prevent other fully atomic users from taking advantage of the
>>> overlay plane. Let's limit the check to ChromeOS.
>>>
>>> v4: fix ChromeOS detection (Harry)
>>>
>>> v5: fix conflict with linux-next
>>>
>>> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2FJIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0%3D%40emersion.fr%2F&amp;data=04%7C01%7Charry.wentland%40amd.com%7Cf5038651be2d44b2d11208d98dba8a8e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637696654602344329%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=83wfZCmSw3IpY%2BRxgnVB4YqABUf8W%2BgYCynDzLvFU7g%3D&amp;reserved=0>>
>>> Signed-off-by: Simon Ser <contact@emersion.fr>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Harry Wentland <hwentlan@amd.com>
>>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> Cc: Sean Paul <seanpaul@chromium.org>
>>> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> @Harry Wentland, @Simon Ser Do you have a preference on whether we
> apply this patch or revert ddab8bd788f5?  I'm fine with either.
> 

Is get_mm_exe_file missing on linux-next? I'm okay either
way but haven't looked closely at linux-next.

Another option, as discussed by Simon on IRC, might be
to take this patch only on the Chrome kernels, though
it would be nice to avoid custom patches on Chrome kernels.

Harry

> Alex
> 
>>
>> Harry
>>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index f35561b5a465..2eeda1fec506 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>>>   }
>>>   #endif
>>>
>>> +static bool is_chromeos(void)
>>> +{
>>> +     struct mm_struct *mm = current->mm;
>>> +     struct file *exe_file;
>>> +     bool ret;
>>> +
>>> +     /* ChromeOS renames its thread to DrmThread. Also check the executable
>>> +      * name. */
>>> +     if (strcmp(current->comm, "DrmThread") != 0 || !mm)
>>> +             return false;
>>> +
>>> +     rcu_read_lock();
>>> +     exe_file = rcu_dereference(mm->exe_file);
>>> +     if (exe_file && !get_file_rcu(exe_file))
>>> +             exe_file = NULL;
>>> +     rcu_read_unlock();
>>> +
>>> +     if (!exe_file)
>>> +             return false;
>>> +     ret = strcmp(exe_file->f_path.dentry->d_name.name, "chrome") == 0;
>>> +     fput(exe_file);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>   static int validate_overlay(struct drm_atomic_state *state)
>>>   {
>>>        int i;
>>> @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>>>        struct drm_plane_state *new_plane_state;
>>>        struct drm_plane_state *primary_state, *overlay_state = NULL;
>>>
>>> +     /* This is a workaround for ChromeOS only */
>>> +     if (!is_chromeos())
>>> +             return 0;
>>> +
>>>        /* Check if primary plane is contained inside overlay */
>>>        for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>>>                if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
>>>
>>
