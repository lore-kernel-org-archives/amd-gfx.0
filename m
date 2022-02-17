Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A99BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0495D10EE54;
	Thu, 17 Feb 2022 10:01:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF2010EE4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwXpzbIA52rg5lG3cWbOaSE9eoshpi/u9GMbnyUw/yHAJawX9CUWgvNfeLRoaHfAC3Pg3DuRwXw/qUXUf3UVgrsC9x3hsvtedxR1XifrVsb5GCn0EChTZob1ou/uM1vS69LtaFomwF1Lio+HQ9/q74zJfLugH6y0hwn+2Hc5je0AqwL5NP9N9ypXu9kiIJLt8J78mxs5TikI99hM98uSgNuhCn4pUqiMPyoBUXSTNOMpVQI/qQTqTTCNndvqL3bbu/5jmPmC1GkxrhmUmZF8dAxdB5xwoTfTho2dwOIwbwksLPT86RyO+1gBD8DUWdQ+qgLFeFHmLXxq1zZra0tbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cClhP2wr1v9W5oJ0t9aaYdKnXedO71XVEppV79nKYGc=;
 b=KS5vkQzYzYXAvmnwgWy7e1QkrjMhgVO/89DoL6Gfc4PGc1B7IkKa2FwLGtMgAK0YanP7U7jjlwRZ8BmP2bEDLPBZBissJLuFiwOhKpad0ErJX8CHQUIMqvKYUloVtrKtxnpaXqBwv9iQ4CMmhU6v7fjllvGtUwoKWXS70feNLgT5EPt60c3BhNOHjXcmrSFqn51e2G9wDTcOZxGFE80ijP1/TRbKJYRQ35e16jOTSH2tmBLW8QqbIhfLWpiZfWvPRf3ou+/72lXZcLJoyvQNHCWGnh0gZndE35vlMqrIeqdwN/dhC0eiH2D7C+6zQo7Xm9tYXC3MKo6QXXGsjo8qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cClhP2wr1v9W5oJ0t9aaYdKnXedO71XVEppV79nKYGc=;
 b=YMFx+BgVn+PRp11XtdtD8fWa0sLQyP5b9ub8mhbpcAfU23yZOlSH7Zmn1jUtNFy/1DkHam88CQWw9c6fwAcWjkUqWrvXK5pD+Oyw8HxyD5HIVgE9cC4d+BFDwJvWONIHAVoz0DIfQh4g6Nz8s0F3f8k3y8KJhwJ2elqp8t/jYls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 10:01:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 10:01:49 +0000
Message-ID: <60b40c93-0cee-dab1-b032-b52fd23ebd8e@amd.com>
Date: Thu, 17 Feb 2022 15:31:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
 <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
 <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6a4ced5-3e9b-4ce0-c84c-08d9f1fc8334
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45215D28605E4EC36B4950B897369@MW3PR12MB4521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aLVRMRbHzfCOY/pqY5CuloQ8XQ+e7LkAf0iHAwE64XquDDVrfBD3DHLMaqhkJmsP7E3ei+R52bcWKlZHObWxRakaP40WyI+VaA+gDp2NIDtToqmrYtHfsh1VX6i8hjL3HM6txexatjs/Hb0r8sMEeBZKal5vrOzyDZTraOtxtLRjemnl15+Q88cySamXk1E0/Vf4Dj9yUDBWV9OqGg3Zg2r9+JAm585jstmbfUDPnuqEY+ZJXtFArdpe8Qgm92qN103j0op8AXXEQIZAbFz9ER+nZZ+yC1ngBYMpfe9/akTtFo2Ky9sQesYivrmVTJbumQ6hykOpIqF2/I18YSzo2Jwthh1LE52Il6fhfyEPLw6f1ZtjM4Hg7JUm1D4UNyuwC/AjjYpsC0NHvqVclcNu9YfJ3hEvnhXaRX+XrrOhbMDBiL81uc9Gevq3P14x4wpFC2rAIr4E1oh/cxaOjwdZl6RaGc4EAw5mwmmRLiVkC5dUaUFeiqyhpDFCEPWtZK69OjyFzOr7WcOEUzWIwcnnzHyhifR9jChTdcPPjqEk8c7Dcfx49gmalW6lFKptL1cCqCMc639iV92KOcmVgw9M1BJ9A3ahr9FTLxCLrGWTEryjwptPOEMvKvKvvEdMyW1iiTYP/NEB+qp4yHOXmQ+e4S8W2sDFQJ3L6ckoPOfLk/Jf6D8BSUeAvEtU1IOeDqj815w04k+B8ybQaoBLl6HJ2VCJE81MCSVXx7vpiNXOmwT9si5BrPx4JDCsXdgeYdB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(4326008)(6512007)(8676002)(53546011)(6506007)(110136005)(6666004)(31696002)(316002)(86362001)(38100700002)(8936002)(2906002)(36756003)(5660300002)(66556008)(186003)(83380400001)(26005)(31686004)(66946007)(2616005)(66574015)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUQvbUtWd3lSK0duYmhjSHlOSmpxQi9zTks4MG05VE1tdS9CYWlSV2x6WHFm?=
 =?utf-8?B?d0pDdWNFMS9tanV3Rm1udHB6Y1BMbmZQUlkwaUpIUjhxc05rSVlrQmNNTitx?=
 =?utf-8?B?eDFmT2F6WTlVN05zN3BKZy9yODhabHEvMEE4TW5NaG45WDRxeVRieG5HWkVm?=
 =?utf-8?B?ZS9PSFMrdFlSVnFVNThZalZNODY4WkRmdGRqVkxON2NpMERYZXV2bno3a1ZF?=
 =?utf-8?B?SFVLYmExeGtSUi9Cc2tIS2hCc0YwTzB6d0FPV3ZIRFJXMHFFL3IvaU9MenFZ?=
 =?utf-8?B?Mkh6dlg1bkM5T1NGc1NhSkVLeVNuSXJKck02Znp5R0ZaRjJMbVBWUUNaek1n?=
 =?utf-8?B?RHdINVFCR2t4bmJqbFYyeHZqUzJDSDhoTVFxV1lEY0xMK3RvQWszOWw0Ui83?=
 =?utf-8?B?RDhhVGZiMDNQSmxDNGV0eXQ0VEJYcktWMlowa0dLb2lJbk00ZlZaTXE4c1VD?=
 =?utf-8?B?S2hQdkVQenU2bmVDcGVQV2NxRzhCdXZqc0tsWEZzWkdxc0l5WllkNHNhNFlq?=
 =?utf-8?B?Q3ZBM0hoZUlFWUt5SmdRbk03di85RXZGdGR4RlVkN3A3N0doK0lITUZRODlo?=
 =?utf-8?B?d256TmhtYnEvRmsxWmtlMitQZUtYTGRyWSs3bFVxdUdTREF3YjdQaXQ0YjBy?=
 =?utf-8?B?bXZmd2c5T0c4YXJ0QnBrL29mYy9WaGZMSFFzLytUTmpqZVo4SkZPb1NEN25B?=
 =?utf-8?B?TGZCQTBqYVgwZk5aRDRSdGJHRkpjanBOT1RTMWk2dXYwVTFCaVBYUnRDN2FZ?=
 =?utf-8?B?b1l6VW9jZG1ES2ZRWXZoWXBia2ZzMklpdXAxYWlNUDI1S0JackNFa0ZTc1g5?=
 =?utf-8?B?bnF1dUdoTDk5a3E0QVIxcHN5WUF0SCtiNXNDcE0yVVlVbWtnQ1pTQ2x0ZGRN?=
 =?utf-8?B?S1JoVGVaVVd0dWRLTlE0SnBia1lndWQveWErRktPWkRFQ0Y4NmR1cVMrNXRi?=
 =?utf-8?B?QkJtY3NWUkZ5bWlkV3QxT2g3YlFydVFaeDB3YzBkSG9NVko4TlBBc3pCc1Y1?=
 =?utf-8?B?TVJsMUJCZytJWDdXWFNTalZ1YmcxM2JUaERVTTBsbCtpMHg2TmNienBMREZy?=
 =?utf-8?B?MGRtQXZXYlNOa0RHR2tFLzhkcFRDOGdKTUozSGw2c1RlNm85d21QNWZBZkhn?=
 =?utf-8?B?aG9udDhDOHVvMk9oM2QxV0Z0REtWM1BWRS9hM2pGMWR6L0d5MExRRys0bW9v?=
 =?utf-8?B?bFBORzQrQ3lIZ1ZVMUZ4M3BVVUg4RkNZSVVHcXltcVdBTFBnODNSMW1WMEVS?=
 =?utf-8?B?SEhhMis4bmZDVlJTT0x0OWFSa29lK1RteEVXc3U4ekRBMDh0NHRBQ3lYNEVR?=
 =?utf-8?B?T2IyZG5tTDhPZkJndEFaOFE4dGxSMGRUNGRaMVc5Vy9RR0FKS283L21sdWdV?=
 =?utf-8?B?emlLbVdyUHgrRUMzeUtQcjludFNtSEpVeGpkUTZ3Q3RQNDNxQnpGeFh6TWpm?=
 =?utf-8?B?WDJ1am1kSm1wQkhlOVYwNW1JQklEYjBVeHByYXR6Y0ptUUpGSFBuc1hxK3pX?=
 =?utf-8?B?WDVsLytDNmhnRzBibkZoUjlBUml4WUpBVTliVE1jMzIzaU1FU1laemtObHVN?=
 =?utf-8?B?SDRKZGc3c2JnaEkyMEM5Yk1PVWJhOUxrY2VTb3pmNGlTMmI2VlcrMnNZbWd3?=
 =?utf-8?B?dmRQZldiZzB1Wm9XQ2NMck9qdDZFQzEwU1RjSitDMk9uNVJUWlpYQVlsSm9X?=
 =?utf-8?B?RDFkTjVSRmVGMGdrTVhER1UyTzh4ajNHbUVZVHNOZytoT3FxRkhJWlZPSEtN?=
 =?utf-8?B?RmZ2RkFsU1lsTjNXSGcyT0grd29xd2crZU1za1VCbUNQaEo2a1A4Vm9Bd1h6?=
 =?utf-8?B?MXh3QjFISmhDd0lIOElkck5JLzBVdzliYVF1ZVJrL3VIaEYzVFA0YjNSSXZi?=
 =?utf-8?B?NG5Xa3VHM1dHQjFCdUJBREtlQjY5clZ0MlU3TEMyVWZ3ek1uL3VuNzBKZExM?=
 =?utf-8?B?RzJBZkEyaGRaTHNySHNCQ1ZDRHRzWk9rZEh4MkY2KzR2STlabGptU1JzQkhS?=
 =?utf-8?B?cnoxZDQzcnJObmJaSjJXS1Y0QXNnazJWa2gxUFlEeG9HY09INzh1NkdyZ2Y5?=
 =?utf-8?B?Nlk2SU1HT2orYVNHdWxsOGlibnl3YS8wMzFkZERDUkRkSHVUczNXejZ2Y1Ix?=
 =?utf-8?Q?Xk2w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a4ced5-3e9b-4ce0-c84c-08d9f1fc8334
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:01:48.8868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsTAyEmjsFa9PBjNwd3/WTyafX1RpI7uXiQ1DNi3+jzkigM3VwwzXgJyIGhY/Sz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 3:18 PM, Christian König wrote:
> Am 17.02.22 um 10:44 schrieb Lazar, Lijo:
>>
>>
>> On 2/17/2022 1:30 PM, Christian König wrote:
>>>
>>>
>>> Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>>>>
>>>>
>>>> On 2/16/2022 8:26 PM, Christian König wrote:
>>>>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>>>>
>>>>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>>>>
>>>>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>>>>> List of register populated for dump collection during the GPU 
>>>>>>>> reset.
>>>>>>>>
>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>>>> +++++++++++++++++++++
>>>>>>>>   2 files changed, 100 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>>>> +
>>>>>>>> +    /* reset dump register */
>>>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>>>> +    int                             n_regs;
>>>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>>>
>>>>>>> I think we should rather use the reset lock for this instead of 
>>>>>>> introducing just another mutex.
>>>>>>>
>>>>>>>>   };
>>>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>>>> drm_device *ddev)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>>>>> NULL,
>>>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>>>> file *f,
>>>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>> +    char reg_offset[11];
>>>>>>>> +    int i, r, len = 0;
>>>>>>>> +
>>>>>>>> +    if (*pos)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    if (adev->n_regs == 0)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>>>> +        sprintf(reg_offset, "0x%x ", 
>>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>>>> strlen(reg_offset));
>>>>>>>> +
>>>>>>>> +        if (r)
>>>>>>>> +            return -EFAULT;
>>>>>>>> +
>>>>>>>> +        len += strlen(reg_offset);
>>>>>>>> +    }
>>>>>>>
>>>>>>> You need to hold the lock protecting adev->reset_dump_reg_list 
>>>>>>> and adev->n_regs while accessing those.
>>>>>>>
>>>>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>>>>> elsewhere, but is not a must have).
>>>>>>>
>>>>>> This is read function for user and returns only list of reg 
>>>>>> offsets, I did not understand correctly !
>>>>>>>> +
>>>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>>>> +
>>>>>>>> +    if (r)
>>>>>>>> +        return -EFAULT;
>>>>>>>> +
>>>>>>>> +    len++;
>>>>>>>> +    *pos += len;
>>>>>>>> +
>>>>>>>> +    return len;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct 
>>>>>>>> file *f,
>>>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>>>> +    static int alloc_count;
>>>>>>>> +    int ret, i = 0, len = 0;
>>>>>>>> +
>>>>>>>> +    do {
>>>>>>>> +        reg_offset = reg_temp;
>>>>>>>> +        memset(reg_offset,  0, 11);
>>>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>>>> ((int)size-len)));
>>>>>>>> +
>>>>>>>> +        if (ret)
>>>>>>>> +            goto failed;
>>>>>>>> +
>>>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>>>> +
>>>>>>>> +        if (alloc_count <= i) {
>>>>>>>
>>>>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>>>> +            alloc_count++;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>>>>
>>>>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>>>>> must be protected by a lock as well.
>>>>>>>
>>>>>>> The tricky part is that we can't allocate memory while holding 
>>>>>>> this lock (because we need it during reset as well).
>>>>>>>
>>>>>>> One solution for this is to read the register list into a local 
>>>>>>> array first and when that's done swap the local array with the 
>>>>>>> one in adev->reset_dump_reg_list while holding the lock.
>>>>>>>
>>>> krealloc_array should be inside lock or outside lock? this may be 
>>>> problem.
>>>>
>>>
>>> This *must* be outside the lock because we need to take the lock 
>>> during GPU reset which has a dependency to not allocate memory or 
>>> wait for locks under which memory is allocated.
>>>
>>> That's why I said you need an approach which first parses the string 
>>> from userspace, build up the register list and then swap that with 
>>> the existing one while holding the lock.
>>>
>>
>> Another approach would be to just protect debugfs write with 
>> down_read(&adev->reset_sem) or reset domain semaphore.
> 
> No, exactly that doesn't work.
> 
> See the down_write(&adev->reset_sem) would then wait for this reader and 
> the reader is allocating memory and allocating memory might wait for the 
> reset to finish => deadlock.

I didn't get this part - allocating memory might wait for the reset to 
finish.

down_write() is called as one of the first steps during device reset, 
and therefore device reset hasn't started. When you say " reset to 
finish", do you mean device reset or something else?

Thanks,
Lijo

> 
> Regards,
> Christian.
> 
>>
>> Other than that if apps are trying to read and modify the list at the 
>> same time, probably we should leave that to user mode since this is 
>> mainly a debug feature.
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>>
>>>> S.Amarnath
>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>> There are 2 situations:
>>>>>> 1st time creating list n_regs will be 0 and trace event will not 
>>>>>> be triggered
>>>>>> 2nd time while updating list n_regs is already set and 
>>>>>> adev->reset_dump_reg_list will have some offsets address 
>>>>>> (hypothetically speaking *during reset + update* read values from 
>>>>>> RREG32 will mix up of old list and new list)
>>>>>> its only critical when its freed and n_regs is not 0
>>>>>
>>>>> No, that won't work like this. See you *must* always hold a lock 
>>>>> when reading or writing the array.
>>>>>
>>>>> Otherwise it is perfectly possible that one thread sees only halve 
>>>>> of the updates of another thread.
>>>>>
>>>>> The only alternative would be RCU, atomic replace and manual 
>>>>> barrier handling, but that would be complete overkill for that 
>>>>> feature.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> S.Amarnath
>>>>>>>> +
>>>>>>>> +        if (ret)
>>>>>>>> +            goto failed;
>>>>>>>> +
>>>>>>>> +        len += strlen(reg) + 1;
>>>>>>>> +        i++;
>>>>>>>> +
>>>>>>>> +    } while (len < size);
>>>>>>>> +
>>>>>>>> +    adev->n_regs = i;
>>>>>>>> +
>>>>>>>> +    return size;
>>>>>>>> +
>>>>>>>> +failed:
>>>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>>>> +    alloc_count = 0;
>>>>>>>> +    adev->n_regs = 0;
>>>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>>>> +    return -EFAULT;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +static const struct file_operations 
>>>>>>>> amdgpu_reset_dump_register_list = {
>>>>>>>> +    .owner = THIS_MODULE,
>>>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>>>> +    .llseek = default_llseek
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       struct dentry *root = 
>>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>       if (!debugfs_initialized())
>>>>>>>>           return 0;
>>>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>>>>> adev,
>>>>>>>>                     &fops_ib_preempt);
>>>>>>>>       if (IS_ERR(ent)) {
>>>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>>>> root, adev,
>>>>>>>> + &amdgpu_reset_dump_register_list);
>>>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>>
>>>>>
>>>
> 
