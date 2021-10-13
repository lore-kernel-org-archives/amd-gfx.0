Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB64610E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFB64610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A810C6E9FF;
	Wed, 13 Oct 2021 15:07:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE42D6E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClYjC4llHo4SMv51I9Uuuo2CkM2Vaq/T/Oc9zhU9xd8R/g8/OVyOkUC7kxTN8nahayTXpIIsejuvyGSRxLz2oi5NVyXO1oPwhr4liw69E4wK5bfqkLk5GQwYLLIJkaWgOLiz6MmdZKusSDzefZzTeHKjKqxbxuKUx9oRvqu341iFC1eRY/9IlWasL8FujF6Oy0jHx8qdDLWl1jzaEwcB62cJyDG4BBXRmOCh7gykzob3yHHtoCI29b/HikMv6/eFEUqAhOthweISZpSIWQd4SihRT0HTnIA6Ko6ECRRWCxw5PTHulA1Dq0Ax7LDlMNcANWcyA9422LSvqvemRIkkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S79IHL4KStfydfCgPLe7HQxGjCkInBFdfbKgjaN4ek=;
 b=GZrvCIvwuV3bYTGfArA2Oa+dSLKrk6a4/zOhCLd6ziiUEye7udoy9NUEhXlJzkCXOD1yR6YNFQDBFyT/cUO7Ctb51JOVhy1lYjtHZnerOGF/On9o1f9x9UcbUXDlygveFCQdNJIbD0k9uK0rZJweEgLO1vQsJZwSbiH3zUygfoZbiI90urM9JVz//dNEoav2GtbNTqg4k8/478uZb2OKtkaAR3udy6LLGKNwSAHFbAu1k+HUxT3YFr8bTWy9I7rbjxRQBZIaCEHOYHhdh3gwiFnCs32FmgX2xXwnam5dPMPxT3KFA6YfZ1bOKhyOvJiz7MBtI23yl4o1+qtna3x34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S79IHL4KStfydfCgPLe7HQxGjCkInBFdfbKgjaN4ek=;
 b=XlpRViD8MCtp9MwzJGRkg1zbXBQfV5hanT4Ie/qYkVYWxerDLKdrrZGRqpH9LavAHE2KhNI79I+IFTNZA7UmBi5MAJb4N58MwMLZvBsmqCu2H/rJlI/XDLraZ5aEnDoMlr3kFDzrXc1t3z3ytBWbFdksSuPNOmPp5hc2vk9DJRU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 15:07:08 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 15:07:08 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: release gtt bo after each move test
From: "Das, Nirmoy" <nirmoy.das@amd.com>
To: zhang <botton_zhang@163.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <2be293df-2656-c551-682e-b08955307c0b@163.com>
 <80ecf91a-1ae3-50e8-df46-01c013a1eeb9@amd.com>
Message-ID: <24b252fe-617b-c086-65eb-7e8ab69bf3a6@amd.com>
Date: Wed, 13 Oct 2021 17:07:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <80ecf91a-1ae3-50e8-df46-01c013a1eeb9@amd.com>
Content-Type: multipart/alternative;
 boundary="------------68AEC84725909B08A919C37D"
Content-Language: en-US
X-ClientProxiedBy: AM0PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::21) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR08CA0008.eurprd08.prod.outlook.com (2603:10a6:208:d2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:07:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452539d4-73e3-444f-cbda-08d98e5b2052
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54166E8BA7D2674C656213D78BB79@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wWtV+yPKs5m9QUVq3EA58qalKVM8u5MXviuB+zQi5m1ABiyk6rJEIJHQuyK6k4heM+daFG8TtjfJcQqv6k+S3cR5HGDPeuNpzPXmA8497p0leMT8TM3MJ5bG8zOcarB5NPvGtT9rOToV0QV333iNMDh1Ni2wwq5pgBQCr08rVJvP5N84WE9Ulv2SGUuM8edrYgFQGINrQyUTmZc/okoGqk9dKHtrMbvZpS859k4CSJTBnX4CwBj9P7YWq+VDxtWZqUi7eJ7dRwTCpTfUfzT0yO3bnTHV6zq7lgoLIm4Wy+lIr7z0Zid3TM5rmUUhE3KyybZCX+wNM3CrqhYb68XCNG8Kdf1qbX1dWPwHgPYoTdItsoBKgvRGu0a7PMQ2QSAnYwgr+tjSw7IhDYWZlZbsy4Yp6PUemNF4vmSFQoDIWMCHzEdXZdTkCEIply7p3cSidNuYTwIxmE7Z+5TsTiF42Vnkk3Xi+sNSJgQnIA3Y3s/UQZ0JgoHSx4LdbFz4hyxVZqCJbY3Q8XB15jat59ZLmy3Hc4TW8eF76/rzMSiUsZiwIRxvf8VYShnztRkP+VV7QbKXxAUJu2aqwIvpDPLQcdtknOknd1L8PQpI1+Y5N/ASlDPVOnpIqWXyHRYXqFtJkBzUDAlKXQdQhwpDcfRxy7TB57xnb3np60evvO7mQNc3Z9ivbqqzaop0rLojgtKvfihXpFjwVEcht5Tj7HhYkAL/zhXQbXwq43klDllRCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8676002)(4326008)(38100700002)(5660300002)(186003)(6916009)(508600001)(53546011)(2906002)(33964004)(26005)(2616005)(83380400001)(956004)(316002)(8936002)(66556008)(6486002)(16576012)(6666004)(66946007)(86362001)(36756003)(31696002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk0xNzlXN2pGUmdPd3FQNHExRkg3U1JLMWY4V2QzRlQ0OXc0TGlRSi95RXhU?=
 =?utf-8?B?M2xSaVZ4UXlJZEVKTjNBZkh0YXNta05PTkNsbW82U3B2VjZzUzlJY1F4OUk5?=
 =?utf-8?B?ZzNKMWI5eXdFVHBuYlNpdERYaUs0NGh5V1FXMVdtTnFocnRhV1ZiTWJuUnF4?=
 =?utf-8?B?Q3kwN0c5MWpVQ2Zua0NtR1RDYlorMVN6MlZBanNJQTFFSS9udXFFQ00vWlNQ?=
 =?utf-8?B?KzVmVDl5UTVRbVlmMGQyUVgwT205Z2UvQ2h3YXFxTFNCcTlBQXFCNHRGMGox?=
 =?utf-8?B?WGd1bHdsOUpCem4xVE5FQkxSN0dOU0VzekNyNEljMHhLYUE0U2dmTi9tYzFq?=
 =?utf-8?B?Wm9zNjRXTWxBdXNZY2s3bXg3NkIraHE4TVhuUDJqRGxjZlJjZmU5a1AwdUVx?=
 =?utf-8?B?K05xcVJ4M21WUFdkQXVqb0F0eG9sMkVDN0pTdGJydzJkdjE4eDFacXM5elRR?=
 =?utf-8?B?TVVwYmV4ZHlkU3puN3FMcFhxdnNiUld2M0hwWk11OVMreTRnaE1SRTE1Q2pS?=
 =?utf-8?B?aWFQWXhXR0xLdFhjd2JxVVJIdXJRc284NHBtVHlTUXZmQTFtNDJhbVVwdTVt?=
 =?utf-8?B?ZVAvZVVQbDE2MlFDQm9TT3A0Mmwxc3Ntb1ZYYlIycUZTTWI3dGxzeGJSY0Iv?=
 =?utf-8?B?NkZ1SXB6T2NUeVJSaXhhcFBMNytpcE1KRDRubmNVVTNtYjN2RE1CMmU5YTU1?=
 =?utf-8?B?eEo3NkR5d0s4TTFFWDUrdUwveWpFUy8yL1ZZYXZsZHFYbkVkcVJWM1NVSTVq?=
 =?utf-8?B?T0VhWU1ETTZpZjlubWl4ZCsxRTFJK0tBSGZMUXlHajdvcHNLcHJ3K2sxb2Ew?=
 =?utf-8?B?YVJNUFZvS0hzaldibFFFZGt5a2tuMFQ2bWgzQlFiK3hMNkJIc0xWQXJjb29Q?=
 =?utf-8?B?eHllaWFxcHdHQkZPaDE4TzIyVmZxb2ZRVnBVaGRDZU5hVCtIcWlIQWpZRHMv?=
 =?utf-8?B?VXJMbENGNVhPSXBtSVVWWkdPdHZ0T3VYM212YU1jUjV4ZStKTVY5M1VNVlAy?=
 =?utf-8?B?SnRoTW13Tytmc1I2c3ptZFQzU2VuR2krZ3V2YjIvYTF6dnVLM1VRN3lPQnhh?=
 =?utf-8?B?YWs3amVrZGwxckVDVlRCRStRWXIwaFkrVWFjeWh2bjMzeUd0TjQvWCsyMHFC?=
 =?utf-8?B?S3ZsdWpjdGVlUDQvUTZ2WWY1Q0J5MkJWQ24zb2F5Tm5jbGhHQnFieGNjYWNt?=
 =?utf-8?B?TDVjNzdPU1Ewc210VWFSSnY0YjRyckp5aXppR2hjM2drbmk0WFpRRkl6Wlha?=
 =?utf-8?B?K2Qxd3l4VDVFUkNTb0c2dXhESDBROWdWQkRZaFByRE5ObVJTS2ZIY3ZGc0FG?=
 =?utf-8?B?MFdQU0NkMDQ3bDR2VHNkaGNEdlVsWkdCWXdBTTFTdHBOMkgzTElpSEtLSCtx?=
 =?utf-8?B?UzYwdFhtZXZPVHBHK0dDTFFWeUhkTWxPTlhIQ1NwM3F2Y1BjOFdTckhucjVE?=
 =?utf-8?B?eGNCMVFlQStSZTI5Y2FCak05WXVDSnRCY0JyYzNXM1doRk9COHBjUUQ1ZDJa?=
 =?utf-8?B?Ynd5NTlMcnRLMUR4OWtSOUJPVU1IR0U5djRjOFArRkNKalN1MXZlOUZlSVBs?=
 =?utf-8?B?cUZ5T0V0OWxrNVJLcjE2VmY4TFZoKzVrcDRWUm1WdTZJaEd0MmZMcSt4Smdh?=
 =?utf-8?B?ZjRqc2w3ZVZpY0V3THM2c1pnbzM2RnBxL1N3UkRQTW9jVzROZUtMNmsxc0dP?=
 =?utf-8?B?MzVHU2tESDVuN29pYXljQnhGUEdrS1B5VXdyN0Rpb1hqQi9IUEsxVTh0Ykoy?=
 =?utf-8?Q?1rwFR7luKeBEWNY1ztANCXlwsGhM56FSjNpWd8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452539d4-73e3-444f-cbda-08d98e5b2052
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:07:08.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx2xx5zC6G0zhjbABQLROcgVG2fH7q6Xy/YrR53g3CT8MrsdWvo1opkVtdQ6zEMIg2z3yHaNqHjA46Oy6r6NPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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

--------------68AEC84725909B08A919C37D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/13/2021 12:42 PM, Das, Nirmoy wrote:
>
>
> On 10/13/2021 3:22 AM, zhang wrote:
>>
>> Hi . Nirmoy
>>
>>
>> If you let continue to unpin. this will  allways test a same va for gtt
>>
>> I think we should  rafresh calculate the value n
>>
>
> Right, I guess then the test should only run till gart size.
>

Actually the test size calculation was fine, it is just that we wouldn't 
release BO after a successful test as the cleanup code is inside the 
test for loop.


Regards,

Nirmoy

>
> Regards,
>
> Nirmoy
>
>>
>> On 2021/10/12 20:10, Nirmoy Das wrote:
>>> When gart size is < gtt size this test will fail with
>>> -ENOMEM as we are not freeing gtt bo after each move test.
>>> This is generally not an issue when gart size >= gtt size.
>>>
>>> Reported-by: zhang<botton_zhang@163.com>
>>> Signed-off-by: Nirmoy Das<nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> index 909d830b513e..0cf2a560d673 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> @@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>>>   
>>>   		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
>>>   			 gart_addr - adev->gmc.gart_start);
>>> -		continue;
>>>   
>>>   out_lclean_unpin:
>>>   		amdgpu_bo_unpin(gtt_obj[i]);
>>> @@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>>>   		amdgpu_bo_unreserve(gtt_obj[i]);
>>>   out_lclean_unref:
>>>   		amdgpu_bo_unref(&gtt_obj[i]);
>>> +		continue;
>>>   out_lclean:
>>>   		for (--i; i >= 0; --i) {
>>>   			amdgpu_bo_unpin(gtt_obj[i]);

--------------68AEC84725909B08A919C37D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/13/2021 12:42 PM, Das, Nirmoy
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:80ecf91a-1ae3-50e8-df46-01c013a1eeb9@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/13/2021 3:22 AM, zhang wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:2be293df-2656-c551-682e-b08955307c0b@163.com">
        <p>Hi . Nirmoy</p>
        <p><br>
        </p>
        <p>If you let continue to unpin. this will&nbsp; allways test a same
          va for gtt&nbsp;</p>
        <p>I think we should&nbsp; rafresh <span style="color: rgb(0, 0, 0);
            font-family: Tahoma, Verdana, 'Lucida Sans Unicode',
            sans-serif; font-size: 13px; font-style: normal;
            font-variant-caps: normal; font-weight: normal;
            letter-spacing: normal; orphans: auto; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            widows: auto; word-spacing: 0px;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4);
            -webkit-text-stroke-width: 0px; background-color: rgb(254,
            253, 235); display: inline !important; float: none;"></span>calculate&nbsp;
          the value n&nbsp; <br>
        </p>
      </blockquote>
      <p><br>
      </p>
      <p>Right, I guess then the test should only run till gart size.</p>
    </blockquote>
    <p><br>
    </p>
    <p>Actually the test size calculation was fine, it is just that we
      wouldn't release BO after a successful test as the cleanup code is
      inside the test for loop.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy<br>
    </p>
    <blockquote type="cite" cite="mid:80ecf91a-1ae3-50e8-df46-01c013a1eeb9@amd.com">
      <p><br>
      </p>
      <p>Regards,</p>
      <p>Nirmoy<br>
      </p>
      <blockquote type="cite" cite="mid:2be293df-2656-c551-682e-b08955307c0b@163.com">
        <p> </p>
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 2021/10/12 20:10, Nirmoy Das
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20211012121018.81693-1-nirmoy.das@amd.com">
          <pre class="moz-quote-pre" wrap="">When gart size is &lt; gtt size this test will fail with
-ENOMEM as we are not freeing gtt bo after each move test.
This is generally not an issue when gart size &gt;= gtt size.

Reported-by: zhang <a class="moz-txt-link-rfc2396E" href="mailto:botton_zhang@163.com" moz-do-not-send="true">&lt;botton_zhang@163.com&gt;</a>
Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">&lt;nirmoy.das@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..0cf2a560d673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		DRM_INFO(&quot;Tested GTT-&gt;VRAM and VRAM-&gt;GTT copy for GTT offset 0x%llx\n&quot;,
 			 gart_addr - adev-&gt;gmc.gart_start);
-		continue;
 
 out_lclean_unpin:
 		amdgpu_bo_unpin(gtt_obj[i]);
@@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(gtt_obj[i]);
 out_lclean_unref:
 		amdgpu_bo_unref(&amp;gtt_obj[i]);
+		continue;
 out_lclean:
 		for (--i; i &gt;= 0; --i) {
 			amdgpu_bo_unpin(gtt_obj[i]);
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------68AEC84725909B08A919C37D--
