Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE35C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 12:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E3D61268
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 12:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95E3D61268
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313766E8EA;
	Thu, 11 Nov 2021 12:13:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8FD6E8EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 12:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYWtW8sdg4Xv5Xmb3CqVOgp/7yO4Qo5Qxm5TvvMk3Vr0fjjN39q/cnncu7klHhsLfuRScfeGl7ll9dXLQTdgYWb0BJa0WFqww7PazvHUvPfAfuN6B4dw85jUpCKTgVW7CT/tNnVEv/KGSVtZhV6K4M96WTCHTLkWRMgulcvw0/IyNs4ikf7FhvULsxXzU0aENVOeqs+sIs3mmM3cWGxy7CC/Px3yv2xUeyNndz2d4khNvPgt/B/wjM6vaKZxyHP1gqCMfYGQr38flyNM0RHfKhzn1dCSUFl5kyu1/qd0hTNnziBEug0wuIxg1zikJbRnDPn5+IuVWlxAwMuZTNxnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x2yv74v6r+NMizHRkZSzGg8rdUxBxMn3r36Hy8YUoY=;
 b=bH0IVrBeKw8DV7BTiXP/Kq8hSnQSSZTq2P2nuTw3NCERcEzAZsc3VrlQyRM7LaO5LyLkSdnCgxv21pO0Sjd3Oygp7dZeXb8Q6XzTQIkiPZekYupYpOF+Al9dk+pWSyuwwDqrGCoQa9Vl7W6psu0qXH75HydZA6ZauUch680Hs9Jm+lken3mhNwxLiXX+oqRozlCLApETIsqxvTO+DAxZN5a6vDQeAjKx5hiFYNL0cuHSCzn/61mVbDf4wk80jSE7LNOQQxFNm2ST02PPibJIAT/HSvJrjCzJn8Km/hBnSW9qrPd6nNAM8bI63QRORr2zMqR75f2/qwv40buaVQcmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x2yv74v6r+NMizHRkZSzGg8rdUxBxMn3r36Hy8YUoY=;
 b=hTO6qqc+JvvvQKT6t0LPuMx92ofEOvOzGenrt5EUyur2yMqpDJzhn6SoGpt8rJgG4Zob83P40R6JD70CvHFM/HRAHKDXIprJ3ucRqRmktBGxiaAUE0SxbXu9EHZ9KpbhSmQzXLCHPLgL1yoIhCpxYdSzfeBMXpgnVFe/0qlqsbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 12:13:09 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 12:13:09 +0000
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <5e646384-ce7a-9a80-f97c-ae9592e39bbc@amd.com>
 <6e566851-0372-b33b-011b-197d8321b875@gmail.com>
Message-ID: <865585bf-84ac-ea2b-7e1d-a13aca7e4caf@amd.com>
Date: Thu, 11 Nov 2021 07:13:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <6e566851-0372-b33b-011b-197d8321b875@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 12:13:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a91c8c-5288-4fe4-e26d-08d9a50ca00b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349C45C5655B09F3D2BA44B92949@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyO9/a3l4uTKUgzSQZClp5vO2/aCZUyqYw6tZXTQx6a1ha8UIVsqLi0rMctYjVOXynj9AzO1Fr55Y+14V/el9KYiT7qfUokY+Iq+E586yHxN1B40uSIuBITF7W60pzniPn/3VBGxjVpz4cv24S4PxGsH8WVEw0ZSVbejN0ulJT9nWvrZrOBkJBvzVVbA2bP1tDl/EsTYVa8/gCXRGCFvqVgCkLZ1Yl7YJVG1HzNhQiTDJZv6d9+3CGk3wcNDTFYWhBdFp12P5b1NUEWlNp+qhbqcL+VIgmXCoJXERN6oCZmj/jGHw/7/0hwF7G8BmEDADeS9VePAuVwwjC7Sdy6QW/Nv12SrJSG14hEpH+ngyEE4zSqIGz7rKVtOlxo5PN3UHfk9FUb/rK8FMkPdXOLIMgDjgI8KmqOykbNvpzby0GvEyUldIYpjqrY/ZyBeq/8x+BpBf0qClK1J3lG+M7srnWp9YuRawWZHu7vH49MqSh09loTI8P7onHJ6Id/aVy6yVCjfeferCHlnLDMw3GwZsEkoPa3dFk5PV7WHSoLcz4MT2/KgncQNhkdvc0gC6Ao35B/fGmbxsBFh/a29tk52Ay9ltT9G6HS+2pTOzeH2af6lnyVCYDt9w96kbT+56By/Qtkss6aNO7dRKhE5ZBG22by4B2LXL0KP7+w81h/bQjYuWtSbSVXMgd1Tx1xNnnde4NR0C51p9hh+BexUirt72kqQAWM3iiJDbUB+gc4auE8AjIboaLx7laD/BzXpjZfD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(26005)(66946007)(316002)(38100700002)(508600001)(4001150100001)(31686004)(186003)(83380400001)(8676002)(86362001)(44832011)(956004)(2906002)(6486002)(66574015)(5660300002)(36756003)(66476007)(53546011)(8936002)(16576012)(66556008)(110136005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BqZW9vaUJJdDY3QXJyWGlNaGZncDFMRkpXRUMzQmtodm1YRXA0bjdlQWlJ?=
 =?utf-8?B?aEJ6eXBFZjRvZURzMExpRjRRdmhGTFZvTGVaUUNkZ0U3RlNTT3I4bTYyd1d4?=
 =?utf-8?B?dW5UK29WMlg1YlVrbUg2REdCUkhyQndIZW43K2hjUzVwRTM1Uktpd1dyN2lG?=
 =?utf-8?B?b0V5Sk1mc093ZFNhdGJvNVlGM0NBbXF2S3RjSnVsSnlERmc3b2RFWWdMWkZz?=
 =?utf-8?B?azBHdXR1VmliSjB1ZDlidXFCYmRKbUV4a0hpKzUranFUcUZFM3Mra0ZuK2xk?=
 =?utf-8?B?cVlOdnMvQWpiZ24wRkNpbXcvY2JpOFZHdlMyUERQZFE0Y2daUklqaGN4dFF3?=
 =?utf-8?B?U2RsN3YwSmFDckZId2ZCMGRNN3hLUldrNm9IS1ZiNDVNaHhPbnJLRWo2RFBJ?=
 =?utf-8?B?Y1BrNE1wangydzZITzkwNGdvU2FNVWRQQm9seEl4amlxRy9zYmJ4Z3QxV0x1?=
 =?utf-8?B?NUdIU2JaUitBL1cxVkdjZHliMTZIcXVqRGNWdyt6V0F1QUg5UUl6bHpjL2NY?=
 =?utf-8?B?S3JpUWdKSUd2eDZKMDJyRUNRaUIyVzRzcXovVktuOWNuaHQzMm84Wkw3QlpE?=
 =?utf-8?B?MFBGNWlrOHZiSkxlTGMxTXoyd0QvRk1Ia045TytVY1VVNHJ2S2VwOW5CakxY?=
 =?utf-8?B?blVLZU5Vc0JzeGFTTlRrbDFhbTkyczE3MXNwb0E5VmZMRG1OdGdLSGtic0ty?=
 =?utf-8?B?OFErRU9xMXpQZ3hhdWQyZk1PWWtWTm5yWUx6ak9TSHd4RzM3R0Y1K3JXcW5y?=
 =?utf-8?B?NS9FcDlwM3hPT0VVcS9qRWJ0bURZdnhETkZtUnhLclZET1RRMWZpK0ZRT3BL?=
 =?utf-8?B?UHZBamc0Rk1KRlBKRU5uakdsL2NwbENVcWRqRmkxb3JIUi9aREE0QWUyZERu?=
 =?utf-8?B?d1ZOSFhOT2R2cy9VWTdRcjVQM3VwQW5qeEl6K2pqdWZMQng3SnlHcDV1LzZF?=
 =?utf-8?B?eURWWGR0VmY1VlB1YjNFRm1QYmRSUUZGbmRlVHRGVXBDc2NXVy8wNlp4czR6?=
 =?utf-8?B?cWFhN1ZFTFRnd0s4UlFDNk5ucnFQSHV1dXJCVmg1NXdHMDAxNkFsQ1pVcmZW?=
 =?utf-8?B?RmptL1BRT1NnK0NhL0xOSkM2Q3ZwRW1oOThuSjdIMktrZFk4N3loY0VlQjJ5?=
 =?utf-8?B?WGduelRtcUpwOVJack5SVnRySG9ydjJOZ2ZuWWs4eGdQMEpuTSs2MHVKUEZL?=
 =?utf-8?B?dzBhZUVyVWdOUDZnY1VsbWZwajhORXF0Z0o2Tm1aN2daWFlkZzFlNEE3Unlt?=
 =?utf-8?B?QUsvRDF0TEJ5ckNYZ3RWM2VRNTh3UjhjMEZjQloydnhnWVVWd3ZQUFdlZGhQ?=
 =?utf-8?B?K3dOSERDbE4xRURCMDQ2WUlERFY0TGVjaSsyNnhrTkZsakdkREVNV3RBd2Nk?=
 =?utf-8?B?N3lNd0hEWmJtaXZRWkg3REhPNjVBUTY3Qll0MGZzcS9qaHhiZDM1bEgwMzAv?=
 =?utf-8?B?N2J4dGpXRk1KcC8xUlp3TUYvYmdZTXpGTE96NmI5WVF4aS9WcDhWVWlseFdy?=
 =?utf-8?B?dlZENks5b01BTjBMeFBHN3ZTVHJqRDJOSzJXZitKRC9KNnUvb0VDRDJNMTRJ?=
 =?utf-8?B?dkk4RXFnRVR2c2Zab09zTHRFbkwzSTN2eW9SNmJlcm00S2hGNEpHQ1RwV2VF?=
 =?utf-8?B?ZmhQVk5VSEdENUNWaHU0S08rdnVoaFpmdHFudlpzODlIRGI4cms0dkN2SGti?=
 =?utf-8?B?cWdkR3pVQ0VTSDlWbTJ6c0NTb0hYNEVLS2l1Q2R4WXBhNWZ1TlZhQ2dGSWZG?=
 =?utf-8?B?VHhSaG1ZOVBJWlNSaVNhZ3R2YXBkL2FQcTVmWUNMUzFLTjJ1WlEzZ0RxRmNr?=
 =?utf-8?B?Mm1XSHRLeVc4S29hNEcwODVJbmFlbDFKUnovQzBOTmk4L29qMUhxVnRIcUxo?=
 =?utf-8?B?cS84WWtGSWZ6ZjRUNTJrTHRmcGFVYTNabmlFL2NFdW04cUYzR2p0bFBvQW1u?=
 =?utf-8?B?aTJIOGpNbUZaLzVqRkZXVkZ6WTlvK21QMGt6YnJDVlhVWmsraHBvbFY4UU9h?=
 =?utf-8?B?TmhJSnU1TnU5SkRLUkZVWEMwRURqTkVINkFyWEQyNmJxZFNnMU9MbzU3YkRR?=
 =?utf-8?B?dm1sRzAwWFRRNTdSZ0RTTVZLajlKcFY4WjU2UE0yS3l4N3BieDlvS1Q4QUlL?=
 =?utf-8?B?N1VKWWtvYm93Qm9ZZ2lXV1ZqUm1tRUlYdXlDTWFQV2tqZXY5RXVTZlh4djNP?=
 =?utf-8?Q?mVxGaoOZ7NFGrCc/hs1tTeg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a91c8c-5288-4fe4-e26d-08d9a50ca00b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 12:13:09.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efoFWT92+xBKFD1Kaa8zG38PnP8oLjjHHRMG9wvduYaOWGAJB3GcQoJXVuuqvuFobOd+3VcVekwp/fuBemHGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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

Am 2021-11-11 um 2:00 a.m. schrieb Christian König:
> Am 11.11.21 um 00:36 schrieb Felix Kuehling:
>> On 2021-11-10 9:31 a.m., Christian König wrote:
>>> Am 10.11.21 um 14:59 schrieb philip yang:
>>>>
>>>> On 2021-11-10 5:15 a.m., Christian König wrote:
>>>>
>>>>> [SNIP]
>>>>
>>>> It is hard to understand, this debug log can explain more details,
>>>> with this debug message patch
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>> index ed6f8d24280b..8859f2bb11b1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>> @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device
>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>                 return IRQ_NONE;
>>>>
>>>>         wptr = amdgpu_ih_get_wptr(adev, ih);
>>>> +       if (ih == &adev->irq.ih1)
>>>> +               pr_debug("entering rptr 0x%x, wptr 0x%x\n",
>>>> ih->rptr, wptr);
>>>>
>>>>  restart_ih:
>>>> +       if (ih == &adev->irq.ih1)
>>>> +               pr_debug("starting rptr 0x%x, wptr 0x%x\n",
>>>> ih->rptr, wptr);
>>>>
>>>>         /* Order reading of wptr vs. reading of IH ring data */
>>>>         rmb();
>>>> @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device
>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>         while (ih->rptr != wptr && --count) {
>>>>                 amdgpu_irq_dispatch(adev, ih);
>>>>                 ih->rptr &= ih->ptr_mask;
>>>> +               if (ih == &adev->irq.ih1) {
>>>> +                       pr_debug("rptr 0x%x, old wptr 0x%x, new
>>>> wptr 0x%x\n",
>>>> +                               ih->rptr, wptr,
>>>> +                               amdgpu_ih_get_wptr(adev, ih));
>>>> +               }
>>>>         }
>>>>
>>>>         amdgpu_ih_set_rptr(adev, ih);
>>>> @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device
>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>         if (wptr != ih->rptr)
>>>>                 goto restart_ih;
>>>>
>>>> +       if (ih == &adev->irq.ih1)
>>>> +               pr_debug("exiting rptr 0x%x, wptr 0x%x\n",
>>>> ih->rptr, wptr);
>>>>         return IRQ_HANDLED;
>>>>  }
>>>>
>>>> This is log, timing 48.807028, ring1 drain is done, rptr == wptr,
>>>> ring1 is empty, but the loop continues, to handle outdated retry
>>>> fault.
>>>>
>>>
>>> As far as I can see that is perfectly correct and expected behavior.
>>>
>>> See the ring buffer overflowed and because of that the loop
>>> continues, but that is correct because an overflow means that the
>>> ring was filled with new entries.
>>>
>>> So we are processing new entries here, not stale ones.
>>
>> Aren't we processing interrupts out-of-order in this case. We're
>> processing newer ones before older ones. Is that the root of the
>> problem because it confuses our interrupt draining function?
>
> Good point.
>
>> Maybe we need to detect overflows in the interrupt draining function
>> to make it wait longer in that case.
>
> Ideally we should use something which is completely separate from all
> those implementation details.
>
> Like for example using the timestamp or a separate indicator/counter
> instead.

Even a timestamp will be broken if the interrupt processing function
handles interrupts out of order.

I think we need a different amdgpu_ih_process function for IH ring 1 the
way we set it up to handle overflows. Because IH is just overwriting
older entries, and we can't read entire IH entries atomically, we have
to use a watermark. If IH WPTR passes the watermark, we have to consider
the ring overflowed and reset our RPTR. We have to set RPTR far enough
"ahead" of the current WPTR to make sure WPTR is under the watermark.
And the watermark needs to be low enough to ensure amdgpu_irq_dispatch
can read out the next IH entry before the WPTR catches up with the RPTR.

Since we don't read the WPTR on every iteration, and out page fault
handling code can take quite a while to process one fault, the watermark
needs to provide a lot of buffer. Maybe we also need to read the WPTR
register more frequently if the last read was more than a jiffy ago.

Whenever an overflow (over the watermark) is detected, we can set a
sticky overflow bit that our page fault handling code can use to clean
up. E.g. once we start using the CAM filter, we'll have to invalidate
all CAM entries when this happens (although I'd expect overflows to
become impossible once we enable the CAM filter).

Thanks,
  Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>> [   48.802231] amdgpu_ih_process:243: amdgpu: starting rptr 0x520,
>>>> wptr 0xd20
>>>> [   48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old wptr
>>>> 0xd20, new wptr 0xd20
>>>> [   48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old wptr
>>>> 0xd20, new wptr 0xd20
>>>> [   48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old wptr
>>>> 0xd20, new wptr 0xd20
>>>> [   48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old wptr
>>>> 0xd20, new wptr 0xd20
>>>> [   48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old wptr
>>>> 0xd20, new wptr 0xce0
>>>> [   48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old wptr
>>>> 0xd20, new wptr 0xf00
>>>> [   48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old wptr
>>>> 0xd20, new wptr 0x840
>>>> [   48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old wptr
>>>> 0xd20, new wptr 0x840
>>>>
>>>> Cause this gpu vm fault dump because address is unmapped from cpu.
>>>>
>>>> [   48.807071] svm_range_restore_pages:2617: amdgpu: restoring svms
>>>> 0x00000000733bf007 fault address 0x7f8a6991f
>>>>
>>>> [   48.807170] svm_range_restore_pages:2631: amdgpu: failed to find
>>>> prange svms 0x00000000733bf007 address [0x7f8a6991f]
>>>> [   48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA
>>>> does not exist in address [0x7f8a6991f]
>>>> [   48.807185] svm_range_restore_pages:2635: amdgpu: failed to
>>>> create unregistered range svms 0x00000000733bf007 address
>>>> [0x7f8a6991f]
>>>>
>>>> [   48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page
>>>> fault (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest pid
>>>> 3969 thread kfdtest pid 3969)
>>>> [   48.808219] amdgpu 0000:25:00.0: amdgpu:   in page starting at
>>>> address 0x00007f8a6991f000 from IH client 0x12 (VMC)
>>>> [   48.808230] amdgpu 0000:25:00.0: amdgpu:
>>>> VM_L2_PROTECTION_FAULT_STATUS:0x00800031
>>>>
>>>>> We could of course parameterize that so that we check the wptr
>>>>> after each IV on IH1, but please not hard coded like this.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>       }
>>>>>>         amdgpu_ih_set_rptr(adev, ih);
>>>>>
>>>
>
