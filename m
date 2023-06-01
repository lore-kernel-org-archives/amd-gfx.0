Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49BBC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 21:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D5D10E5D1;
	Thu,  1 Jun 2023 21:17:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C3F10E5D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 21:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPNRzczzO9eKpIid2THZaj3wmDa9DGUBHwGZzR+nBf493ZssjNsl01WsJtMHUbXTygqeeHFSk3w7ES1q1r/QQGazKiCrcL9y21uHlkGQclMRq55i9IvoaiYtZh2KyhYK2EE7GqjcLC8491yVXfEOOTWwPDSmxenwiCbMWcUffu8w9IBVZ2vy9zf2MuNjZzRqJYccOo8wotgWrvDr0cU2kEZq4HAGRZd093qFobpdq/5tOHKjwOXPeWVqdXxdV17DO1AjBHq9u6eOaOVncV+qoKgTPgvmYIXWyp8H2JRdRUjzt3JdwQciFLPxszx04ebHA3B2wUyxu+4tEXf1ABUZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxrdxK0worDzpy9cdaBee4J1JOeVnYVYIuCbLcBMJc4=;
 b=HT8ITwSSO4BSAkM0QmwSRog9Kf2xcW0tJHRglTGHQOifJTshtICh4tNGPR+i7rklQPPuNHKrRjyJjG389WNUNPRcXZK/P1HDS5SAkz0ftwQSDvif/OLEXTvcNH7n6p2Iv8eWMZM+wH0kJPaB3bBOmRX0QM+ORcCTmDnUcuER2jnLGjULkpbJc4LFgPawW60Cv802oof51v7k277oTKjsRxlM88DcuvEOQkwodOLwj8dtrNauKjqZNTWVtlG/YALCCJ5TwbW9vUj/GW+bNkZQNq0Qnz/vBILubpSdqljbF/QteuP1cDThmgO8RoSUiHP6/1gyoBqABGDcdSmzgAriIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxrdxK0worDzpy9cdaBee4J1JOeVnYVYIuCbLcBMJc4=;
 b=LFIe+ejHbePoRLsaeOiapw0fVJwFhlST6cc08uDmvY+qxhOmjUPgvLCaX3eetU4ZBFgSozHRldGYBzOzkWFrRlavqLx+hS+h8MHlXF3Cf4o0++C58f7gmjr/iQRDG0pDmlEKppGlG8qhGvyA8H1EcnpKOxYSxbf3DHelndFjHAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 21:17:36 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 21:17:36 +0000
Message-ID: <04b12a87-6672-3241-456e-f6947f09de27@amd.com>
Date: Thu, 1 Jun 2023 17:17:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: don't sleep when event age unmatch
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
 <20230601204740.1501616-3-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230601204740.1501616-3-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: f12fb732-ba86-4772-5994-08db62e59f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+zH/Oa9zzzUCtKm1up8J5WCJp5qpbxZ3srsieL7tzdi82oVRLHoMC3MJ8jG29PQJRsRsJiXWSQXpCR0uPrt21KM9RMkVSKPrV5o6cUOptksoR7HA2nc/iwfJ+VSp4aOUgye8/06zFqaYG4iQioXVWSAJ0oX8eWT39pNOELnYGIFNeZAHTMgEm6DApsxQo0gc5QvuKp5Ag2hUZAzVdI/k/52SM0SbZsRV+cg4ThGkMa9d+LOUMMOoZWQ4HbTrccwPguFQbj1fsB0EpGk6fQzTom/n9UhbB+0kxTXX6qx1ovaq/DKtmMB5Z1S5vEWaoCJx6tE2G96nY2e2qARHOk+tEgeUhfPiQqk6BSII/XXGaxWOR1xInk6yjjqCp1pQBg91pMcpB0DHXMFSUqB+D34TIR+/E7SlAQoC5fjrPcWS+bxyy71hDDJKx6lQ8hsrUs2KmLekNPpWg8/KMRMw000aEqlRWCbDC9nvvcZdcTE5uaG7VQSKWz6LfrQ3MLMyphw+yKS4KVLEFBwENzvVH+msEuLasXo5QqlAPUk8ZEhZgye+X7PfLNQZisleg7ZOMNP5rUWnbHZ921X3DqHQCfvOv5pT5d+qdkCJlR79w7U+F8RodgIGvluwUbivk0WatScJceZb0LYJpGpKXqfDWkF2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(44832011)(316002)(6512007)(53546011)(6506007)(186003)(6486002)(8676002)(36916002)(41300700001)(5660300002)(26005)(8936002)(83380400001)(36756003)(38100700002)(31686004)(2906002)(66946007)(66476007)(31696002)(66556008)(2616005)(86362001)(4326008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJlWjBkL3ZSSytKbjk5ZUlGd2NCZXFlcTFGbXp0SFJlaFVXQTM4MDlUVTRh?=
 =?utf-8?B?STFSS1U3Zy9IQ0F6SitxRHpaNG85eHVYYUZLQ09lcmJZUjlHcTRiNGVOVUZp?=
 =?utf-8?B?eDZHc2NHYUVTY1JOQU9nTTQ1eFkyUXY2N2E4Ymd3NHJOZ2FxRDk4THoyOEdY?=
 =?utf-8?B?VGJQZFZqbDE5R2lOdzFGWTF6VS9FSlpPTURyNTd5UU5oaGU4Zzk5OU1nT1Iw?=
 =?utf-8?B?VisyTjlKdUU0U05zRUhqR1prVFJoOXZGbndxclRFTlV1Yzk4SmpPMktDNzVk?=
 =?utf-8?B?cklNTWxPZ2VnaHBLczNkMGQ3MFZ4emF1ZGlqd2FZRDJSSkVMRzRGTDZmN2VS?=
 =?utf-8?B?ZVV6cWdBREhhcTlwRWRHTG5NQWhjbU9mSkZCdGlKbXIwWDNkNWNVSy9sOUM4?=
 =?utf-8?B?TlhpY0hRZ1I2S3pVUWFIVGJDOWtIUFBQVFFyZStNN2o5R2d6a3JFY1BSWFdO?=
 =?utf-8?B?OU5lbTlDb0J0Vm9Rb3crSFFzV1A2cUhsRHBuVmJmNGl6K093QjRxU3Q1dzhU?=
 =?utf-8?B?dG1rMnN0ZjhrN3BsWWQrL1paUkpYOGpHV3FsbGRXbkc4bU1NSGZyTHpvNytS?=
 =?utf-8?B?WXJYU1lLQnA0ejJTbng4TjE1ZDV4TjJ6RFZERWlwUzNOZDV5ckJpQ1lLbnB3?=
 =?utf-8?B?R01uVVF3VWdqUXhZRWxBVmZwVkUyaHhvS1hXL3h0R1dKMU9rT3ZNSDB2SWZa?=
 =?utf-8?B?amFoU3ZuZW9GWGFaKzZuV0taekZGVmVHdGpZd1VlRWR3T3p6eHNGZVd4WVox?=
 =?utf-8?B?Z05HQVVQVmxRVEpVRi84dDFIajF4ZkRMdlVZbE8xSkQrU2FaN1B4ZlpxaDhz?=
 =?utf-8?B?OTdubzNSR3Erb2M1U2owWDdkT2lDQ1M5SDVuUVU2WHlkaDg3Y0ZCeHVhSEdw?=
 =?utf-8?B?elkySnp5bm15dEFHbHBMekw0a2pjMVNxSUFSTFBWSjdPY1ArLzdOYk10d2ww?=
 =?utf-8?B?NytZUk44dURrS2NKN2JKKzh6L0p0ZFBOeTZQdlFpVWk2OE94REZuS1ErUDJN?=
 =?utf-8?B?MVBORWJHZ3Vua21XRjhFNG40bGpRd1M2UFVkdWJGQmpTRlBudlBqelZVYVRr?=
 =?utf-8?B?MGpTV3hCbjJUbURjdVNvOUpZVm40VEtkR3dGNDNORDRqb1RNSkdTQTVYWWQr?=
 =?utf-8?B?Y3RnRFNpZGowaS94UUJkSjRDVFkxMDJvdnRHSmZreVpseFYzWUlpcjQ1ZEV4?=
 =?utf-8?B?UEhQOWIyazRPMzV1WnNDdzJleWJWN2JrK2ZQeHk3Q1J1MS92RVEzbU9Va25C?=
 =?utf-8?B?Nzhkdlgva3BrT1h4dXd1OER3RmhhZTJsZkZ4UWVnZG82emdSSExGTWI0bnlw?=
 =?utf-8?B?VXdFdWsxTzNvZ0dETkxkMVNmbXM3Q2I5Y0lodTJaY1AwaEROMVk3REdaRUJC?=
 =?utf-8?B?OWFsUnFOekpNT016ell6ZXEycllpTE5GV2x5aGs1eFllbjZmaTZKNURsNTNq?=
 =?utf-8?B?R21XV0I3U3JBbE5DaDhCKzZhZVA1WldTRndJSWxJLzUwZks5Z1NzTEdPRjZV?=
 =?utf-8?B?ZGVLR3pKb3pmSWtsWEJpMWJlMFRReDNDL1R3Y1A2UldXME5XNi9XU3Y4SFRr?=
 =?utf-8?B?THMvd3dUL1hwaU95UFIrRjFPZW5CUS9xOGZod2czOTY0and2aXlvNm5RTVd1?=
 =?utf-8?B?d1B4SXlGZ2F0NG52cDBDaTVuS245c1ZGczVCWS81NEFtMERkN1Nra3VJajk4?=
 =?utf-8?B?UmtxazlGRHdhTU1vbjU1ZHdDbnpuaU92R2dCWXRBUm00RTQwc0k2NTZ1bmN6?=
 =?utf-8?B?NnR5ZlozQWVpWE5WUlA4aTlqR283Kzg4MHM1TC91VmtBQ2ZQZXk5d09vdk5t?=
 =?utf-8?B?bkszc24wVnVLMXh6WUIwanFIczlFaGFPSVV2YUExSXNyQXRCSzlCYkFpT0dh?=
 =?utf-8?B?dnpiNHhqSnkxUEdneTU0NkxmRGg3Uy9LMzNDay9UV25qaXlZeDBpQUlMRnFR?=
 =?utf-8?B?VGc1U3phM25PeXNRUysyM1JPRkw2NnNoWkpENGlhZHBEMlFYUEY1dFBuSzcv?=
 =?utf-8?B?SGdkeGdOc0k4NHZ5c2dnbksvN3NyeTIwQzRsVUJwSC9qMVpPNWtqVjd2cEJv?=
 =?utf-8?B?dEN0c1IwQ242RzdTOWptak1wTVFTVDRZeGtiRWdUdFI2emNiOTROdGF3ajlN?=
 =?utf-8?Q?zC2stUgGmSYsz0jFg5M8BIP2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12fb732-ba86-4772-5994-08db62e59f54
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:17:36.4514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFbCJTF6xsH7WhOnPpXUFXD8470nDDGMqsK2UiGeTeYK+xV7b2Kvt64DK4i+Bu7igoKf9/8HTMoMaj+v7Na/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-01 16:47, James Zhu wrote:
> Don't sleep when event age unmatch, and update last_event_age.
> It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index b27a79c5f826..23e154811471 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -964,6 +964,19 @@ int kfd_wait_on_events(struct kfd_process *p,
>   					event_data.event_id);
>   		if (ret)
>   			goto out_unlock;
> +
> +		/* last_event_age = 0 reserved for backward compatible */
> +		if (event_data.last_event_age &&
> +			event_waiters[i].event->event_age != event_data.last_event_age) {
> +			event_data.last_event_age = event_waiters[i].event->event_age;
> +			WRITE_ONCE(event_waiters[i].activated, true);

I think this is probably not necessary if you're returning before the 
first call to test_event_condition.


> +
> +			if (copy_to_user(&events[i], &event_data,
> +				sizeof(struct kfd_event_data))) {
> +				ret = -EFAULT;
> +				goto out_unlock;
> +			}
> +		}

When waiting on multiple events, it would be more efficient to catch all 
events with outdated age in a single system call, instead of returning 
after finding the first one. Then return after the loop if it found one 
or more outdated events.

Also EFAULT is the wrong error code. It means "bad address". I think we 
could return 0 here because there is really no error. It's just a normal 
condition to allow user mode to update its event information before 
going to sleep. If you want a non-0 return code, I'd recommend -EDEADLK, 
because sleeping without outdated event information can lead to 
deadlocks. We'd also need to translate that into a meaningful status 
code in the Thunk to let ROCr know what's going on. I don't see a 
suitable status code in the current Thunk API for this.

Regards,
   Felix


>   	}
>   
>   	/* Check condition once. */
