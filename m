Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F706C43219
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C87410E31B;
	Mon, 21 Nov 2022 17:29:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1326110E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoISAHXCbQDzHfESOt7ImO9O+RrVDwtYNJKD7zmyJBaqYt3O1At0mIOhW1vYcupGPhlzXG+VS4+FigKPa8dJlFIZEGLIOTBle2i2Iqn59apBYO4iGpo/jkYPUqUvVzouuMsXwVGo/r8jLayBiWw0Qu4XTUW7/TL1hbm7scgeX76A6gOH7+gI2wDwQN7qKu0x1n6QCSHqkZKxUMGQhoLas23nJs3mpjV9z1979IPXWsjF3DePA9PrXI4dKbHf8Xg2kjwl/bR1eHenqjJV3Oki0kFLbEPZVvgs4JztQsBAS4AvPdpPKus+Z525YGOfScoe+pDGb/uwf1Im3gJy5kpmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhhthd4Cv2y6lD7ZoaIPNk2XULVbVpr7HGUdgRpqVpU=;
 b=fQUVPdr7EK5cTMaCe9w5rEjTG5mDBKlBp1tUJOq+xJgyuQ9Ff7MuiDBCg+QH2yYfdkpmquT42N3pz8aNFoMhyqKK6Gay6L42GhUDuMhzJ8f1lDBnzUOE1BVB+frcOHEMkhPMebfGhiizUYL1NYENOEIOwNieeWuZkQ4cfnOea2etsYUUi3lOIQh2ateSyQ0OEADh8GSvNJ3Vnm4HWHK4KOVWFIavI9jsLkDkbkCBJeXRR+f/fQrB0fGlVGFrqwdg2vGRUuMtEw22jJ5XTL3hdEZ90NeV2l9yidbuYnsnIjhHLdJDDw8n9wlTWqBVxgqGirR9zs/mRSSHBnEg8KWlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhhthd4Cv2y6lD7ZoaIPNk2XULVbVpr7HGUdgRpqVpU=;
 b=B0pl3ce4jqn4YfYkGIxraAhBD8/hdjVRZ2zLFAa0rKVU03GFT68HL4YPujDj5W12571tILT3H1Mm2fwrxJJa1P1TUegJO8LOd4Eemj3XXINCQEOL50kbIlTzySdZJJi+bqvj06Lo3muaigp6HsuQrHPl+LMCEHzXN3PGXO6ZHyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:29:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 17:29:13 +0000
Message-ID: <9ecabdd6-a7cb-2f96-243a-4d2c12fcb607@amd.com>
Date: Mon, 21 Nov 2022 12:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Revert "drm/amd/display: fix dpms_off issue when
 disabling bios mode"
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221117144933.1218097-1-alexander.deucher@amd.com>
 <CADnq5_Pcvp2Ftt6kGXuCbub6_kraxURV_WkpJN53_wuVFPeDMw@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_Pcvp2Ftt6kGXuCbub6_kraxURV_WkpJN53_wuVFPeDMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: ec22269c-5df8-4b0a-86d9-08dacbe5e845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwPPyCmGZsa5ss6SCy6YtFL6NDaet0DYKpAZZD4RoY6GhoiplL9QyXB464jGxGe/5ZUGDnN22bR1W94LyvI2Hxx4a8p+ckJmJfRcDiKryI5zGpu3CavJbBrcN6MZDqmPxM5NeFC2SjviyPM2x6Zqkk1FmnA5k3YB/Tru4icvX0SBnOCZyaaS9aWDlpLXCkDohAOqNHdmf/7jehza9cX1bXEXggArrK9RF7lJDaeEk9rIAHUpXt/+UHZtokgIurr95i7VXgjjrT3cXcigAIru/EjwsF9FaiQjG9GrHiljBu4KXhv26aTv4Ld9tTDOSFNOlJTcPKh3e1/vXIT9QlQO7TlYdRwhFCCfElCBTipyQ8hoQLr1OrO1cbPtt3vevlxdz8LIfLcqLUzQgaIC4TAG2xq1/E4Ag3SlrUF01Wz5MMEh9Fuzuy1aM9krp4hac23EMESzHg+/2bEIyI5jidBQBROMCvPeWQrAwVG6F/VNbT+HeMjEbHyB3dCjI0gVQNQdnMZb1tlb4E/78VCUkWakeSI/c+xY1TC7WkJ6TgBa6pSMQPvoFVraMZfV86P44PJjYs2R2ga05SJqoiLsvJYuEE+MAngK80DgbQrDhsG9K9an+yJdNrM2XmeWq/qZPO6gdKdJQJyQds51EP838f5JpZhiBnbAOlyUsm21+Mlx97U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(4001150100001)(2906002)(31686004)(2616005)(66946007)(66556008)(41300700001)(31696002)(86362001)(36756003)(6506007)(110136005)(6636002)(54906003)(53546011)(38100700002)(4326008)(83380400001)(44832011)(186003)(5660300002)(66476007)(8676002)(8936002)(316002)(6512007)(45080400002)(26005)(478600001)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ozMkxLb0p0ZVVaSk5XaXhNU1dFVUg3eEtMbVQwTHNRRHZWK2lkSFN1NjFG?=
 =?utf-8?B?SU8yeWJkRWlXQ1NncVozUHAzSTJZUnZxbkxMSkcxbEd4clBSejdibkxHNHpR?=
 =?utf-8?B?YS9lc1hRQ1hBVnMwSXJhL3N2Nkl2ZVZCbTFTWlhJcjRkbFhwKzNFRWRSc2lr?=
 =?utf-8?B?cWhNN3kvQ0drTnRGUkN4cmdOWjZGcklSOVAzZDFyWjQ5RnllM29hSFhyOGZI?=
 =?utf-8?B?TFF6eStMMGdSNmhkd29LbmRkUlExQVNQeVBJSnNCS0drV2JJdTU5NEpUejFa?=
 =?utf-8?B?SWJ4WUhOdGY1MTc5WUJkVnc2QWltaVErblBISmgyZ3lGemo2NWRRNUhJekJq?=
 =?utf-8?B?K0JiWFJaN05lZ1ludjJIb3ZlL0p3V1QrU1dpNVVhMVJPU1RqTG42WjF3NG1u?=
 =?utf-8?B?M3gyR3VOUEp3OTJIeFZKNEFmajZCVVhWMnlORVpYdlEyZWpMaGR0WVUzcXEz?=
 =?utf-8?B?cnN4K3Z4aXR5YTV4azFQVFRYLzYxdFZKdmE3YlczK1hPdjlVbDB5ZHhLQ20z?=
 =?utf-8?B?bFNtRnVzbnNQQlJxZGJnYkd3L0pvZVlZUGxGclppbk5Uc1hoVkpyMUZLcHM0?=
 =?utf-8?B?b1RYUngwVkZNTHBHYU9tWmlMeVFiZldHVDdNcENvVHIvc3VVTWs4QSszUW1M?=
 =?utf-8?B?aHg1Y1VCd1p4eWFPU0MvbktNNHJEYXUvZUp1TnhuUmZ5VEFtQ2d0WTZDckRH?=
 =?utf-8?B?N3laQWpuV21heTRzb2RyTHVhVU16WHllVkJiY1MrMitJbVlIYzF5NlROQW9U?=
 =?utf-8?B?aDhnQUtQWVg5U290QTZ4Q29yMjBDdUhoU2hYTk1aWHNwYktZM05rT2t1WmZ6?=
 =?utf-8?B?Vzl2dmdpazhSalpDNjNYN3RYSU5kZ3E1bWR2RE91YXh3WWU2SGR5VG9GNFdM?=
 =?utf-8?B?Y2dIWGExTFR6Q3VFcVRCRnVCb2k4VGQ1c0d2bnhoSnJycC8xNm1CU3FyQVJM?=
 =?utf-8?B?a2pkUWVTenZ1RHg0czNLOGJZOFh3UG83Nk04NHk5RHVCVERTNWRTSXlJZzN1?=
 =?utf-8?B?MElSbzZNUGVyVHFlOG5DWU5ZR1hzUEZwN3JaOUNhcnJDWVErMG9pcmlBcUtG?=
 =?utf-8?B?ZEZ0V0Z0bnM5dGxhMmNEaXlBNm4vdm5INTdDcXJSRHJYVmswaVBoc1E4SEVq?=
 =?utf-8?B?SVhjUmt2REdLUUtNczFwSlBvTUdVT2JQVUNSV0hUbWErdnppSU1Mc3hod1Rp?=
 =?utf-8?B?dUxtWXNFdWkxWmZGdkJINzhvZ1Mrb2poczFnZCt4WldHQWZ1S0d4eTJ0K2g3?=
 =?utf-8?B?VTlxbWcreDhIb1J0RUxPeWNkZVE4TTJUQmhGaGNzbHAxQ3NsTENSa1p4UGlm?=
 =?utf-8?B?VTlDeTVOUkFCZEtPdnZUVWJsZDI3ZW1mZS9EQVFCd0JIRGVPU3VqemJLNVhh?=
 =?utf-8?B?djJPUjNNT2RmeVhoeDRBZWJQVGwzRy81S3dLS1VGUTEvV3ZpWHZNRTltaVFG?=
 =?utf-8?B?Yk9VOE83dU1KbytuWlhmaWVURnJMZEZubnZpTTgrVXRFaEtxaDhpUjRGZFpu?=
 =?utf-8?B?MTRIckhwanZ5V1hXYkZUYUpSV0RnSzUwdHMrVlZBVzYrZVoxUFlHWmVLUGZX?=
 =?utf-8?B?MjEvWVQ1Q21OZnhIMmluRWpER1hmN05uR2h0clNlQmRYSlZjYUNxa2ErL25W?=
 =?utf-8?B?QUNPU1c3RzFJUFZZd0ZFMDNaWTA4QU1jQTA4S1BtQ1FUclZMMWhKbElUVjls?=
 =?utf-8?B?S3loYlNXSDVUc2N3OEtvWlljYWZpUjNDVk5mTDljNHZDZmJlcWIzVTNNcGZQ?=
 =?utf-8?B?L01QMkwraHdvT0tkaVNTRGVlZGdKeGVkMFBMbys2RDJ2QlN5dkJkU1lhRnlx?=
 =?utf-8?B?NTRlY3RFam9pcjJBUkFIN2R6cENEOHk0TFVYa21DaWozbGVPQjgxWFJheTYr?=
 =?utf-8?B?aTNUY2MyWVVmZDRLWUFNY2hRUm1LWHhNWEJBaVcxQjNra0ZoTlA3MjBHUldR?=
 =?utf-8?B?eCtleW1rUW9UUXpMMnVrV0E0OERyR2lsNWRZQk9HZlFGdUQwcy96VUJXRStD?=
 =?utf-8?B?azlmWWpjRE0veE9POUJ4S01tL2cwQ0tPRDB3SkY1NlIwRDJFYlhjRDNudXF3?=
 =?utf-8?B?anNQeXFFbVlyK2pXK25Ld2VQLzA3YloycU00cy9DSnJhUmZkMmJ2ZlViUmJB?=
 =?utf-8?Q?n5rYJXplfInFzEA8WNMtCPlX3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec22269c-5df8-4b0a-86d9-08dacbe5e845
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:29:13.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1fZqVhOeTlzAzJ16f+REKe8LWOuCx4nQ/pW1NEdGfrRMLUovc8z1pbIrlgF03/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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
Cc: Zhongwei Zhang <Zhongwei.Zhang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-11-21 12:26, Alex Deucher wrote:
> Ping?
> 
> On Thu, Nov 17, 2022 at 9:49 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> This reverts commit 5aa663752ff6f844c6bfc97d89231e98884ae769.
>>
>> This causes a blank screen on boot on an Asus G513QY / 6800M laptop.
>>
>> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2259&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C7195e71123944bfc820208dacbe59400%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638046484140489919%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0WlPsYWutXT%2BdwnEGeZEzceZs8LAqfH8yu%2BGcQiy3uI%3D&amp;reserved=0
>> Cc: Aric Cyr <Aric.Cyr@amd.com>
>> Cc: Tom Chung <chiahsuan.chung@amd.com>
>> Cc: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 1c3de3a1671e..049ef31ebf69 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -1192,7 +1192,7 @@ static void disable_vbios_mode_if_required(
>>
>>                                         if (pix_clk_100hz != requested_pix_clk_100hz) {
>>                                                 core_link_disable_stream(pipe);
>> -                                               pipe->stream->dpms_off = true;
>> +                                               pipe->stream->dpms_off = false;
>>                                         }
>>                                 }
>>                         }
>> --
>> 2.38.1
>>
