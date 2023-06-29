Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C75EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769C110E3D2;
	Thu, 29 Jun 2023 14:26:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ABA10E3D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abc5agIGBq7v16K3LySrthF0wMc/X2bKahb4H1y5Je0VwBRbnCtlSrG6WSUpuMs36vzpwxtPdOXnYCG5fNHtjqJTSnh09AKPXWOx0GyeKhsoD8xJJFrIrDtIXAUsXmOBnVdBOLpazBZlhFLbctSnI+4ldNv+VJpyI9becjc7aIx21ST4hhBalL+lyUXKh+0t8T7CoAdlBwX+zy4FWLLCyJr+wrrD0ZY1IRHbJ3B+BZq1Q3f3z1ifc6vHFFjtdesC+Q+AnGoLOmkSZ9xr59v5MKm52spNMc4DmU/3i9oE9j/fthNJxAmIAYxKpsMAXljFeIscGYaQEROqjr6EXlX+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0128PuP3J9KeKY07HDclf+5wraDj3pEfBQa/q4sldes=;
 b=dfzh90IhtUIPsbUR6pBv754V9ztafMY8c0QNNIjPqVYYhNgLQqw3Wyri3NOkd6w1/R/v3okoAOQXyxrCfWRr5u2yF4E58jdrAFKWGuIDi1yYYxy/pGBYivEMaZSfBSLmKrLmgGE2b01Hn8YBrC5RMOQ9z1YqjtGC9m/q11V2ZKqFX7eWhrHkrXmnRHlsZZ9rQyBXgxSdDCvJ6nr5rNr0UB8+N27o7e8DTnOzYaqzxq+aZHgxoujRBB+kffcL43zUDRKkVGKbJvvvMAsYCXPs+qkUDQsWO6atEjBGgmXPy0iq5vLaBZOPs/fAgcJPoJwzuS2Yhx/daX4gYVq9fmGM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0128PuP3J9KeKY07HDclf+5wraDj3pEfBQa/q4sldes=;
 b=M/0JBNC4JyUcPT5DyEGwz06Ddw9LxfVGHcK1hMcPMehRVaZKH12NDv5QDUl6buaHs1ChtmrEVqBsaOL7LSmS40jk/IuWCpdzQndXNM3t0OkKFZCGmmIadN4eedcn/z30ejmIjn1KmJwT5fxAv3gMHFqbbBsZOqmxf5HNa4ia8cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 14:26:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 14:26:15 +0000
Message-ID: <fdc34c13-6852-57bf-ab26-4b9165380783@amd.com>
Date: Thu, 29 Jun 2023 10:25:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] drm/amd/display: Fix warning about msleep in
 amdgpu_dm_helpers.c
To: Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-5-srinivasan.shanmugam@amd.com>
 <CADnq5_MvZuEt_tAFZiggObrA3OJ1sXenm50su5VAjOLhWtQ1UQ@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_MvZuEt_tAFZiggObrA3OJ1sXenm50su5VAjOLhWtQ1UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: a1780efd-4cb5-41ed-d8e9-08db78accc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56vBVfgFdJWZ5jn5B7lyFmFCfKpLewrwRXFmQLwnnGnJ6KBjUwzPdykYsG0k8N8cL581FKjCJ9Ol1r9VS1Jxbk7pwLEZyEzjjbPuq2cyTKv/9gvTU66DXwYeyslvmquf36xYb4fNIjHMEVrl3zafKcQqcWcUpLANVhINtPBqgsZ00ZRGrkGjtgTlBpeOelZwMZC0iogv1Jwpe3y80JsICSj4OMlczaWZhDcJNveWO2Cenc27jI0Uo97BaHF9W6OK2dOrR0qbgCcc1LIGxRlt3MjtFo5FqzYGBTJlAat58U/BFs+fIghadZCMnPC5QQZTVyxygN6PGQq/+ZrClzJhOuYJqVcb/iLhq9Bm/B4OiBKT7p8UaO4ButDHRgBkZlqGvI/ZQhKaORGXTFXsOARLWx0nXS7RxCtxY74il7RbkAepkGrSJwxP3vX22hV8cctn3L4WpIbE7gBFhqYuV+LdKVq3n1odh1LdP6kKWc0DI2XjudUKXW9j1nsGL6kWe16R5wZj4yiNc7aDRJ5sDqx6KkVsf81onqENzlqzKiGOTcVP1bWvxyAYOrmFLUjykEBdHTijO8HvdPyInM1K7WBBXwvVpOStm9knMtWwnirtDvEOm1F2TaMJhWrCPakO/HhdpiyZZJQS/CapebuvTsFpFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(6512007)(4326008)(66476007)(66556008)(478600001)(6506007)(6666004)(110136005)(54906003)(53546011)(6486002)(83380400001)(26005)(186003)(2616005)(2906002)(44832011)(36756003)(66946007)(5660300002)(8676002)(38100700002)(31696002)(86362001)(41300700001)(8936002)(6636002)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGhaV2pCT1p1aHFkSDM1ak16ak01OGVHWXNucVJVVU1kOXJTdmFpb2pUYStl?=
 =?utf-8?B?VFRsRzFYZ0ExRDFoRm8xUklLZXc5SGdqdHJwc2lwbzZuTk1rb09jcFZvNjNp?=
 =?utf-8?B?cnNvZFZNRGxsb0kwajgwbmdSNzZMK3N5b0NaRDlqYThNbk5iaUFoejBaTyta?=
 =?utf-8?B?Z3hCNmVuWk03ZE0rbUxrT0xiNFRPcWVBNHdMRG5hbm5hN052M3NkMldxZGJV?=
 =?utf-8?B?RXY0b1UzaEliM2g5WDNXR0J3U0NIMDJGalJFWVRDU25YOTRVd2YySElxdVZC?=
 =?utf-8?B?M3BlWU93Mkx2SElrTGtZL0ticXBnQnM4UjJuSS9YQmE0MHBBekNqTlptV25R?=
 =?utf-8?B?U2thU2NOTFczTnlEbWtpbFhoN3lMMThieDhQTDlsWFVaT2l1cHkrZE51dnMz?=
 =?utf-8?B?MU0xV1JOdzJkWUtWRUpJYlQvZTdOQUNxVEp2b1VDbjRGTFRKL3hwKzdOKzdv?=
 =?utf-8?B?Q3hJcTBMTXNqeXR3RWcrc09aalNwOGc1T2pBZHFaVnI2azE1Wnd5aENGU1lx?=
 =?utf-8?B?UGcyZnBYYXNOdU96Zzh3TWhVcVN4bHpXTGJ0bWFjUDBzMjFRZ3A2dnY1QVlv?=
 =?utf-8?B?MnA2RVN0L0R5V2U4WW9PdldiNkpYYmd2cUNXa3BrUHV2aXhWZWZPRSs5dERz?=
 =?utf-8?B?eVdCSzdRVWVYcFZkNFJPRllSSENxVDZBSWZHVlg2clZZQnB1T1Q5bDlDUWNC?=
 =?utf-8?B?akNJVE5BUHh0bE9KakZSbjdDUGhOQkNDaE1JbU5pY2NZSHY4Z2dzc1hvSU4y?=
 =?utf-8?B?K1Rzb2MrU0hPME1QYk8vNmIybE9lZUYzcU5IVHBmZmV1ZTltUjRONHE1dDY2?=
 =?utf-8?B?RUlNR3F5TUpJd1BVVWVxR20ybHdmUFZSdVF0bnRUUFRpejFqYWdhbWUycXdq?=
 =?utf-8?B?Vk5IRW5tbDdSL3lMaWM4WE95cnpqNUFJdWg5YXUrM1h2TFN5M2xvNk9YSXhi?=
 =?utf-8?B?T1NRdGdEL29QVzhja093MVRsOExBY1c3RDdzeXJpYnFoQXhoNXd1V0lqdE1K?=
 =?utf-8?B?dFloc001cG10UGJmQjc4THRIU1h3VFdXZDRXMHpXRURKdVUyWlNHdHV0YzF1?=
 =?utf-8?B?M2hBaC9KellYM2NpMGFLMXdtQXpzWHJCaklha091SDVxKy9CRDgyZERFc3dM?=
 =?utf-8?B?eG9DVmtqOWRTcUVDdTE1YzVSUzFzQ0tuTkR1RjF3YmdXVXZPRjBoUGRWeUdJ?=
 =?utf-8?B?V0V5Rnc2RDQrZi9ZenlNSUxlQTZsZ3dwYnhyUXorSnI0dzV5M2QxZEtka2hF?=
 =?utf-8?B?aVlHTTlScGVtT1JnRzE5VW43Z1JCbHA4NUFIcTdIWW42Z0tYcFFCQ0R6ZmFG?=
 =?utf-8?B?cHRicURCYkpiYVVrK0JUTUIwY1U5NEhQc2VVb25IbVV4ekZFZE02aWV6eXFV?=
 =?utf-8?B?NFdzaUdMMWl0dkY2Q3ZjY3J3eGRvV0thNGxpOGVmaFRrUjQ4SEVYMWFkWnU4?=
 =?utf-8?B?aWk3UktFVEpUcnUxYUFwRTFDeXdRYU90SEx3eUNpVkRHRmNOQ0gzL29MY1lU?=
 =?utf-8?B?bDRZd1dJSmp3YTREQVRHSGhpMWhtNVFpR0dIak12SkdlNjQ1ZXNBNUlSSG5v?=
 =?utf-8?B?WmgvYkVKcmdMdVdybW5LRk83QXRDbG1aRTMzdCtMT3U5U0dOK1E3ekxuZ0Mx?=
 =?utf-8?B?cERXMzkzRVB6N2p2WHFRVk8wa2dFMFloUDc4a3dkajV4ZXZKQXRxeDJmOXZX?=
 =?utf-8?B?clkyZ2w5Ym1seW5qVUNhOFpkZjBTWURBNXZrTkt2K3drSnFPMWFUK2h0WmlZ?=
 =?utf-8?B?d041TVhWS0ZkeGR2YWIxYTJ0ZmRmdm9EMWRuUlVxa2g4TS85UEpYOWNxZXNl?=
 =?utf-8?B?azV6NzFJVG5jNGhiNExjTytDRGVRWFhMUldEVDdXYTVUdTVJaWo3dGFLMDQ4?=
 =?utf-8?B?dnJObU9lZEI2VHVoclBlWkdzTlk3ZjYySzdiRXFUMXc3NGMrUTI3cGsrTTdU?=
 =?utf-8?B?emhtYlM2SWxhbzVHRUVTRVFSVjlQeTVLc2Z0SzhkTXNaQldoODh3aU00OEpM?=
 =?utf-8?B?YkJGUlVXSEpHWWZsbkxIWUtaRUJDbVZFWU9BRlRIaXlwdGVZZ05lcWU0ODB4?=
 =?utf-8?B?Yng3SXRwSUdlSEwvWUhvc09Ga0kraHBVYVhNOFdBRFYwLzNCbjJyYzZWZ01P?=
 =?utf-8?Q?H7+pDaT4Ig9vYBW9QdtaC9o0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1780efd-4cb5-41ed-d8e9-08db78accc20
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:26:15.9480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EhnBaQQvzYoWAN/mKVhPNqhV7/EZHJHvA8uJxSW18U5mYBYnsOPEfb5lnt9ly5eGFvljhDyxq/g1gAqSEp7dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/29/23 09:53, Alex Deucher wrote:
> On Thu, Jun 29, 2023 at 12:47 AM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> Fixes the following category of checkpatch warning:
>>
>> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
>> +               msleep(10);
>>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index c13b70629be6..a6be04ad387f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -643,7 +643,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
>>                 if (rc_cmd == cmd)
>>                         // active is 0
>>                         break;
>> -               msleep(10);
>> +               msleep(20);
> 
> This doesn't seem like the right fix.  The warning seems somewhat
> bogus to begin with.  If the length really matters, I guess we should
> use usleep_range(), but if not, I don't see any reason not to leave it
> as is.  Sure, it might sleep longer, but it might not.  Better to have
> the code stay as is since 10 was presumably the intended sleep time.
> 

I agree.

Harry

> Alex
> 
> 
>>         }
>>
>>         // read rc result
>> --
>> 2.25.1
>>

