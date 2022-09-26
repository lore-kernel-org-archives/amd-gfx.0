Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EABC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 09:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA02810E658;
	Mon, 26 Sep 2022 09:21:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DF310E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 09:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu2ATzchtSqlqusWhQFPoF3gsvgkcWfXu4xlm/o28xBetWnA+b2nfbJ+B5YTnk5i2zE3B4VtBsgrGLkIuybUvCGDuXnIDL8/uhJEK/2Aa0/D5myLjVtfUq9QUaE9P7YfCf4C0efegFZEHiUy8EHW24tmebxSZ2z7f1Q4ewkKmdqwb9W5AdMu2OFGB1gG0Qekk5Wgd4ttnApUKFQuoIx+F7em7iTJfky1w/cj1OnusbV2Y7EtpUhy2pPM9uvRrlkXa+5ZARIn5OwxBnS9io7BCB7wYp4ABgpt0dOi+v+BMa+reyHNAHk9nnzg9Q0FF6YcMo4GlIgF/OFrLQVMLUfBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glycbzegHdt0jyNNYA4N8WhMCdhO8SPweJrBzxFrxDQ=;
 b=eCecOFZt4hN4kVU9CZnkdDZQhMVrU/JbKxaOFDlLOIesIFietC6lJJXrUOlCrbRunfXEgcWVQjnqMzRiRB6mtEPxn9cm0yaCM3u0CG1thVIYjyzBR+cyKWUCkSpo13B5fkIhRMZx2BxV7wGQMaMohb2Wl4NNikdtSSZA+PUhaUVGdN5BQZyE0PP0oRST5FGoD7zQ4SjOG6ngnUdo4SIkFG9wRzh8dJ5y9wu1udVFhW5n9YA0yhVVG7sey18qGGmAXkM1+JfcX1C34gycSh2MVTBAtI1Y4+e3D2uknihBh5TCvFhdIosd/0Yf1n/jP1Vapb0gV1No1F8VMlrEuUUgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glycbzegHdt0jyNNYA4N8WhMCdhO8SPweJrBzxFrxDQ=;
 b=UlU3Z4VehJtv27ecvVRuPr635s+U7T66+aOPzpfVQKUkccmuzB1fBQ3/ZvqCo4oR4lHSoplF5LgUIWiuvKlTqEI31JREDRl3E8HAK0M8pM4/e0SxD5CC00rnmr5bUVt9qRuqPEGe0lPWVVfS6jbr26Cs+RVCGrNGt4mWZWgxVp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Mon, 26 Sep
 2022 09:21:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:21:38 +0000
Content-Type: multipart/alternative;
 boundary="------------RTVBmqqGd0DByD92oZpvoumg"
Message-ID: <2feb4983-1258-e4de-4efd-9d90f6bafa7c@amd.com>
Date: Mon, 26 Sep 2022 11:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220922230452.3903316-1-ytht.net@gmail.com>
 <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
 <CALqoU4y-3dWJ-gR8RxUFry9KpT+FMNDfb4WmvEoK5bc56ueUvw@mail.gmail.com>
 <8fd109a0-bf1d-befd-a9b5-c02c2104df25@amd.com>
 <CAAxE2A7jgTq_TiqK+V7aYPMd7rW2xATJSyVRcyRXpXreo3o4eQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A7jgTq_TiqK+V7aYPMd7rW2xATJSyVRcyRXpXreo3o4eQ@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ee038f-f42c-4540-0b03-08da9fa08391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5swn98dSV2NRZc8gMGuRu2ZlpKxqpNEfkaQJ68Kw3m0gHF5riGwS6T4t8ZA6uNhg90hVcLk9fkhMyE9tm1Z4YDyNJ4gnaHJ0+Hr7mziMaP0xhmzQYa6W8kI5qpljCkiKFns8IS7yXrREdyCLu2HldcjltV6bonMt2ZlRsw6U9d9nZ0QUzoTRUoPe5H0lTZKG24Ih3iZ5tTCVW2gF24tQfKmMvheUPCcTkhmNEvnHCYojPezrX6LdMDxsqSg5o6pjAOrCIbEOfoh7mgoZPMIv1OyXdfGCU3NCAaSCSCxgU4psFC0g4/8VQrgcSvb65duqfed+F8AGuoLf+4XuGFO8vlahyIJvUKBnTbRwpPIRN+b17pJBoQFZj+HvciJ6jZ2FKOIlwduFxxr6gzku3MyxLHZ17zhQmzG8nRV9CsmTbH5F9Y5VlwwSeij1n5lCHNERjgv3oIi4IHEHzfEOqFhIg+mkZy6k/zqjfm5xHMW2+8P2p63YjHIlXvzx/n4nq4UL5F2jxfjHzCIQhD1lsslqNiO3ebTIaPsVUz8yaxA6dgkOFTedkcmcghSi+Bgm4YU+XmK178/sjkGDEgcvw6U3JYNzkTckpju9ebv+KQBOVEVDmmfiU8j8+OdCFJW71nPiRGzHmeHyV/HEK36vhNlavO3BZnpEiVlFDYAGEmIIXuZkQNKowD7gjkq2+gWzoj8oEf6PilQW0CblzRxZSCO2C1MTAK1KoGRt+ACIF9Rdi2VoNjT82fO1hIYDCrT7wcvb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199015)(6666004)(36756003)(31696002)(86362001)(31686004)(166002)(4326008)(54906003)(66476007)(66556008)(6916009)(6486002)(316002)(8676002)(966005)(478600001)(2906002)(6512007)(38100700002)(26005)(5660300002)(6506007)(53546011)(2616005)(41300700001)(8936002)(186003)(66946007)(33964004)(45080400002)(66574015)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmswbzZxTmJEcGJ5cTNUbkRzcEs1OFNxTk5SU09CMEVueUdSNnR6SklDdWZ0?=
 =?utf-8?B?RlRRelY5ZzNzM3Z2NThFUERxVSs5Si9aMjRMSFN4MStQdTBaNHJSdTVUMEhu?=
 =?utf-8?B?T29oRzlvNVlPL1VPelhSQklrd0JoVzhiZmxDVFlsNjdtbGQycjZaOWRlUmVu?=
 =?utf-8?B?ZXo1MTlUWFJpQ3AyeW1xYmVzSXlhbVNoVEoyM29IUndsd1h4cTFLblhzbDhR?=
 =?utf-8?B?ZHdWOE03VExpVkFYcUpzQTNWUUM5SEhmWjZvZ2poS3hXbTlJSmhYTEgycFhM?=
 =?utf-8?B?dzdRb2J0RDVlaXhXc2VCUUY2ZGVzcVJDQnlBSWZSRmtTd2F4c0pGcVB1dEpk?=
 =?utf-8?B?cklZeHZSaVl0clhLc05oV29WbFJpcUc0aUZiR2RkdlVVMDhwQXJqdUdiRU9C?=
 =?utf-8?B?TytTMStRazI3UXNlZ2xDZnRpWkk3NXdFRk5SYitXNmhLY1Z3M2hGUTVjTGE3?=
 =?utf-8?B?Q25YMGFSM2FjQlJwQXlIS2p4enk1Um5oOStVYk5tektUbWVyenh3cjVRUnYv?=
 =?utf-8?B?MEdzbUM3NnpXRGg5akpObU5zRDcxTlZia052Rkw1aVJyUW1LNGdZZWRBVnps?=
 =?utf-8?B?eTBsWUNldlJnSW9ydjczUjlKa2liR2hHVXZRcEc3NkY0K3BTcGlkSVlSWkVK?=
 =?utf-8?B?VkxDaWdteEZPL1hDd3ZZR2VzSTd5MnB2R1RhRFNCRDBZNHQ3OFBkVVE2b0lj?=
 =?utf-8?B?Z25meUNCR3J3Z3FJbEl6Kzh6V2p6S3lMUXdhNW1tMFk3Y3piSzhTUG9vajFR?=
 =?utf-8?B?VlltcVp6cGdrOHpmRklUVVo2bmg0M1NRSkNVMFFEVkJWdWU0NlBwSEJXbnJ4?=
 =?utf-8?B?TzMrVzFIdTF0RjJmdUwyc3BSNHFPcytyK21hRkNKNXQ0WkNoS2VlVU5rOTcz?=
 =?utf-8?B?ZFpIeEJFZG9zWW1FUEdMS2N1SWZvRGlza0xHNStCeE1vR2hMRXpVR3A0MUZK?=
 =?utf-8?B?ZGxqR3NoODRucERQNEc1WXU0NmV0V2cxcTVEVTdtRGZKSUFJVk9hdHc4SE5X?=
 =?utf-8?B?c1JWUEo0cDJaQTlxZEhoeDFaTy9KZW5ONUp3NWRqZ29NU1I1bHRjNkdrZUo4?=
 =?utf-8?B?RThvaXhJOTZQd2VYOW5lMldBTHhzR0x3aDYwbGd2U3FVN1UwOFRHaGtuQ2Mr?=
 =?utf-8?B?c0VGVFNVT2x4a2FVS2h4TCt0eDE5aGw3MzdoUStRSC9JS1NPeXJsTTFHaC9J?=
 =?utf-8?B?V21Gb2hCRVdxSEMzNWRXUmJhMUQwOXluNldzQ1VkN2hwdVdmbFUrUDh4MUJt?=
 =?utf-8?B?RDNmaEVTNkxDNGRiS0Q5MHY5N3FtdEg5NHdIWmllZVg2cFYySklMalFYUUdw?=
 =?utf-8?B?Nk5Oa1Y5aHZJL2ttQlcwUFljenlNK0lOeTY4VjFZWVZWcVRZNTF4RVdTKzFT?=
 =?utf-8?B?VVRBL0dJMy8zbGJLSFVUMEdlNzR2YVVRVGxrbWVyYlVyejN1dlR0dWlwd0RF?=
 =?utf-8?B?dDRKTHdJRngrc3NXRFhzY0RzdXFqWDR2d2theGZTWDN1QkJJaW05QTEzUExQ?=
 =?utf-8?B?MzJVcWFiUkd6eTVkSzlGVFpyRDliTExjK2hqVE1tUkdmVWtJLzFaZndjT29s?=
 =?utf-8?B?ZTJma2c3cEFNMnhNYWt5Z3JsRHdIM013YkYwd1QzSHlvdk9XMmZWZjZWTVRP?=
 =?utf-8?B?RTdMN1VxamhSUmliTDdzcnpQbzJnV0NUaFVHdGNacnBDVGtleHBIOG5xUHZN?=
 =?utf-8?B?RVM5U2wrVnJUR2NnL0k1VXBKalFUSEJvZmN2eGFtNWx3YWkwVUlaREdKV1NU?=
 =?utf-8?B?emlGYTZERVBhRGNKaERyMFU3bHpXNU85Y1NBUXNwcDRTWFZOZXQwN3NkeCsx?=
 =?utf-8?B?ZVVQN1l1bHVhUEtZbkpaUVpoeE4yalltbHhSdWJ6Zk16Yk5NMmRRTnBRdUVl?=
 =?utf-8?B?NWp2UlNXN0dhd0JCM3Mzd041d0xRL05IdzNWRGhEeW1ZUnlyMDlpUCtSVU5u?=
 =?utf-8?B?N2QyUzJ0TU9LOGxtTUhRNk9ob1pTRVpieWFreXl2OGhYREV1eWs1aDdWOFNE?=
 =?utf-8?B?N1ZwKzlTb2ZrMjI3T005cXEwaDJPRXVmYkZsY1d1WFdTUG1pYWYrYlhCNnh2?=
 =?utf-8?B?Q1BpRjlUMDV2NEdLNWhKMVVlNmlHdmRQeTFXZURhVE9KNjg5c3lYTkdTK2F5?=
 =?utf-8?Q?DMvFrhekvXsh0G5L0/6h0EkJ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ee038f-f42c-4540-0b03-08da9fa08391
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:21:37.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF0xM1n13PdoO8t4edkgZBsSrPswzO1EHJvRY2tH+mnnTcStETjcRSEfXoImOSRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 lepton <ytht.net@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------RTVBmqqGd0DByD92oZpvoumg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I was thinking about that as well, yes.

Might be a good idea to just change the alignment check in 
amdgpu_bo_create():

                 /* Memory should be aligned at least to a page size. */
                 page_align = ALIGN(bp->byte_align, PAGE_SIZE) >> 
PAGE_SHIFT;


Something like ALIGN(bp->byte_align ?: 1, PAGE_SIZE) should already do it.

Christian.

Am 23.09.22 um 08:23 schrieb Marek Olšák:
> The kernel could report the true alignment from the ioctl instead of 0.
>
> Marek
>
> On Fri, Sep 23, 2022 at 1:31 AM Christian König 
> <christian.koenig@amd.com> wrote:
>
>     Am 23.09.22 um 07:28 schrieb lepton:
>     > On Thu, Sep 22, 2022 at 10:14 PM Christian König
>     > <christian.koenig@amd.com> wrote:
>     >> Am 23.09.22 um 01:04 schrieb Lepton Wu:
>     >>> Since size has been aligned to PAGE_SIZE already, just align it
>     >>> to PAGE_SIZE so later the buffer can be used as a texture in mesa
>     >>> after
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C645f6878a7bd487588b708da9d246c4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995077041120091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NMEAl8TByDLQFWW1d%2FaJfiGrXc4mpwL5dxNH0M0QH84%3D&amp;reserved=0
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&data=05%7C01%7Cchristian.koenig%40amd.com%7C69c0881fd97d4de3380408da9d2c336b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995111117539790%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=KMiCYD7blJCjO9zcfsqmy9%2FfYbtAmMHbrwpzHP7F5O0%3D&reserved=0>
>     >>> Otherwise, si_texture_create_object will fail at line
>     >>> "buf->alignment < tex->surface.alignment"
>     >> I don't think that those Mesa checks are a good idea in the
>     first place.
>     >>
>     >> The alignment value is often specified as zero when it doesn't
>     matter
>     >> because the minimum alignment can never be less than the page size.
>     > Are you suggesting to change those mesa checks?
>
>     Yes, the minimum alignment of allocations is always 4096 because
>     that's
>     the page size of the GPU.
>
>     > While that can be
>     > done, I still think a kernel side "fix" is still
>     > useful since it doesn't hurt while can fix issues for some
>     versions of mesa.
>
>     No, we have tons of places where we don't specify and alignment for
>     buffers because it never mattered. I certainly don't want to fix
>     all of
>     those.
>
>     Regards,
>     Christian.
>
>     >> Christian.
>     >>
>     >>> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
>     >>> ---
>     >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>     >>>    1 file changed, 1 insertion(+), 1 deletion(-)
>     >>>
>     >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>> index 8ef31d687ef3b..8dca0c920d3ce 100644
>     >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>> @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct
>     drm_file *file_priv,
>     >>>        args->size = ALIGN(args->size, PAGE_SIZE);
>     >>>        domain = amdgpu_bo_get_preferred_domain(adev,
>     >>> amdgpu_display_supported_domains(adev, flags));
>     >>> -     r = amdgpu_gem_object_create(adev, args->size, 0,
>     domain, flags,
>     >>> +     r = amdgpu_gem_object_create(adev, args->size,
>     PAGE_SIZE, domain, flags,
>     >>>  ttm_bo_type_device, NULL, &gobj);
>     >>>        if (r)
>     >>>                return -ENOMEM;
>

--------------RTVBmqqGd0DByD92oZpvoumg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    I was thinking about that as well, yes.<br>
    <br>
    Might be a good idea to just change the alignment check in
    amdgpu_bo_create():<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Memory should be aligned at least to a page size.
    */<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_align = ALIGN(bp-&gt;byte_align, PAGE_SIZE)
    &gt;&gt; PAGE_SHIFT;<br>
    <br>
    <br>
    Something like ALIGN(bp-&gt;byte_align ?: 1, PAGE_SIZE) should
    already do it.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 23.09.22 um 08:23 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A7jgTq_TiqK+V7aYPMd7rW2xATJSyVRcyRXpXreo3o4eQ@mail.gmail.com">
      
      <div dir="ltr">
        <div>The kernel could report the true alignment from the ioctl
          instead of 0.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Sep 23, 2022 at 1:31
          AM Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          23.09.22 um 07:28 schrieb lepton:<br>
          &gt; On Thu, Sep 22, 2022 at 10:14 PM Christian König<br>
          &gt; &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
          wrote:<br>
          &gt;&gt; Am 23.09.22 um 01:04 schrieb Lepton Wu:<br>
          &gt;&gt;&gt; Since size has been aligned to PAGE_SIZE already,
          just align it<br>
          &gt;&gt;&gt; to PAGE_SIZE so later the buffer can be used as a
          texture in mesa<br>
          &gt;&gt;&gt; after <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C69c0881fd97d4de3380408da9d2c336b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995111117539790%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=KMiCYD7blJCjO9zcfsqmy9%2FfYbtAmMHbrwpzHP7F5O0%3D&amp;reserved=0" originalsrc="https://cgit.freedesktop.org/mesa/mesa/commit/?id=f7a4051b8" shash="tWZ/wSFytcJujLRNLlQuVPu0GEQzU3dY7OQK9ATquLkHfpsKql65oFr7ZGju71IstnGuM4ElKmeZ3EJnWu9AcnyWuun7wPM82YmJQvlP7bLR1BMSuqfrVdMJvaX/nPuaeYB+JLBbEiT/9FdBdITIL3/4S2dOWwWNf4VUUkHwGqE=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcgit.freedesktop.org%2Fmesa%2Fmesa%2Fcommit%2F%3Fid%3Df7a4051b8&amp;amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C645f6878a7
 bd487588b708da9d246c4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995077041120091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=NMEAl8TByDLQFWW1d%2FaJfiGrXc4mpwL5dxNH0M0QH84%3D&amp;amp;reserved=0</a><br>
          &gt;&gt;&gt; Otherwise, si_texture_create_object will fail at
          line<br>
          &gt;&gt;&gt; &quot;buf-&gt;alignment &lt;
          tex-&gt;surface.alignment&quot;<br>
          &gt;&gt; I don't think that those Mesa checks are a good idea
          in the first place.<br>
          &gt;&gt;<br>
          &gt;&gt; The alignment value is often specified as zero when
          it doesn't matter<br>
          &gt;&gt; because the minimum alignment can never be less than
          the page size.<br>
          &gt; Are you suggesting to change those mesa checks?<br>
          <br>
          Yes, the minimum alignment of allocations is always 4096
          because that's <br>
          the page size of the GPU.<br>
          <br>
          &gt; While that can be<br>
          &gt; done, I still think a kernel side &quot;fix&quot; is still<br>
          &gt; useful since it doesn't hurt while can fix issues for
          some versions of mesa.<br>
          <br>
          No, we have tons of places where we don't specify and
          alignment for <br>
          buffers because it never mattered. I certainly don't want to
          fix all of <br>
          those.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          &gt;&gt; Christian.<br>
          &gt;&gt;<br>
          &gt;&gt;&gt; Signed-off-by: Lepton Wu &lt;<a href="mailto:ytht.net@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">ytht.net@gmail.com</a>&gt;<br>
          &gt;&gt;&gt; ---<br>
          &gt;&gt;&gt;&nbsp; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-<br>
          &gt;&gt;&gt;&nbsp; &nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          &gt;&gt;&gt; index 8ef31d687ef3b..8dca0c920d3ce 100644<br>
          &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          &gt;&gt;&gt; @@ -928,7 +928,7 @@ int
          amdgpu_mode_dumb_create(struct drm_file *file_priv,<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; args-&gt;size = ALIGN(args-&gt;size,
          PAGE_SIZE);<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; domain =
          amdgpu_bo_get_preferred_domain(adev,<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          amdgpu_display_supported_domains(adev, flags));<br>
          &gt;&gt;&gt; -&nbsp; &nbsp; &nbsp;r = amdgpu_gem_object_create(adev,
          args-&gt;size, 0, domain, flags,<br>
          &gt;&gt;&gt; +&nbsp; &nbsp; &nbsp;r = amdgpu_gem_object_create(adev,
          args-&gt;size, PAGE_SIZE, domain, flags,<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;ttm_bo_type_device, NULL, &amp;gobj);<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; if (r)<br>
          &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------RTVBmqqGd0DByD92oZpvoumg--
