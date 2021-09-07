Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F92AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 13:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C553861104
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 13:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C553861104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AF889F03;
	Tue,  7 Sep 2021 13:45:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9D989F03
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 13:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+La+Tmo05LKJpfZNHLRxg4wNdHiB3rrX0+UdsukshZm919ythUmwfrWNSm4WW0hTzC7rDNmkApCjGHINusRKkOxP/T7AReMLEVep4XD79VEXB7CFzvUHYDzvu3RDWkAtrjsbf6/gYIRBk7AH9OTAytRk3d14N8u2pib9IXUpN5PhK4WJSbABmwqrf/f9KjjQ/S6Oe+qvZAPcfHmYoCzcSY/YA+4fdnTR9g6y+70rAXJg7XeDiGLgD2paeR9cLZ0weFK4Y66b5JLlYE6l9mCZ+4CphbRR4fg0MuL5as9mnmOMxdp3QKnLdZGpmcoej9luDlT8MgxlnEjCIXQULKW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=O/1jv4P45pENfgkiwyCq9EiUN8z7WbDqPlJhiJTi+hg=;
 b=mVXxNrgNsmaTL62bWG7X6zmzK2YfyEXhP332yghJ6dC9VSB/Syhno10lel7kYJFhVCX4YQ7OnvvQAB/WS75O5aEWs73wSWCUo5QJorNCNnFMcI3OK5paXyd9C0/WIkDEy2aN0T1TtK3xJ/CBgr7WyBAGInkJ1U9TJi1FfXdzh4oNM49pK/ktv2QtwYq9mgaNG22XcqL6o+pu91O4JRjHinZH2XY5gSXlVQuWh8zkc+t0HFjCw3zVIqri9tI6PMqSHp/gbyX8ZhV5rZ2xei1TNWQbY5iJWZRP8z26cq1OXq25SmWGE6AX1mrdKxs+xc5cCmN0cZzGiSqHbMLV7LJZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/1jv4P45pENfgkiwyCq9EiUN8z7WbDqPlJhiJTi+hg=;
 b=0dQqgd2SdFxXFRWhVrpdJTKz7o1k+zGncBhagzSPkZW3CkCPUKtFS6WmKutCIdp6Bbii+o4q2Dv+z/z+VjzkXIRe1qaKh+mbyQJwZPiPtAjt4knWmW3IOif51VQIGRD+UaTMHPtrAwOEbM237RZ//v6XQiRhMtVppoQcJIrXnhw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 13:45:40 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::55b7:27c8:7147:8222]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::55b7:27c8:7147:8222%3]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 13:45:39 +0000
Subject: Re: [PATCH 3/7] drm/amd/display: Use vblank control events for PSR
 enable/disable
To: Mike Lothian <mike@fireburn.co.uk>, Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Qingqing.Zhuo@amd.com, bindu.r@amd.com,
 Anson.Jacob@amd.com, Roman Li <Roman.Li@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
 <20210813063502.3106309-4-Wayne.Lin@amd.com>
 <CAHbf0-GfTL7k64io_2ORFYfT717MX2WJqs7DHY7ODwWDcx-6LA@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <0a2d28f9-d258-2977-6b57-d8224801b713@amd.com>
Date: Tue, 7 Sep 2021 09:45:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHbf0-GfTL7k64io_2ORFYfT717MX2WJqs7DHY7ODwWDcx-6LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 13:45:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3049e8-f270-4817-2233-08d97205c75b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5072B396B788AAB963DF0C34ECD39@DM4PR12MB5072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYs/N2wldwU1Nk+FhwGc4IjX1DfOH6wITXvhQWGGLBmoDVzm1jZM27hdsTpSL8NiO2a0t1g3YcGNyZzdL2NY9XdcGHM5v0Jj1Y2uuiXm21N5/2FVcWrJ5NCPvxy4emmR5tbpDXxe/ge1lchlUdsTJKJSmRpd03AICkCUBhDXcE9ABMHKtUPBnK1WqCwyDEUpP1RlW9AEm6AW89yGRKaqq0xOmykE3wdECH3PFEBb8DZKIIwqlS7v9WXM4tGtq0EGF7kvKjJoJ2w6LWuJ9SITW4tKUdGxAmhMbke9g3tvIgxNx7wOp64ASQ0L5NQ3+IHn/F9QU2n1C9jwYHkxFeILet0pq5+WJ3ip1t82SbJsvBznVI4JWOJbR9n3T15o1RdkT1WggUFNna2eQfbc+pFIBOggdjHxVzXZDlJewX0BtVwsCUb5cXTVP9csjrHUImZKC/TS3Gs/aDOF8hsfkMIYtgwj0QGcv7wsZjx7Ug2H0lB2o3nF2FelEt4w3RYDH1Eb1VpB9XFxxC0sIXbwyo+UXUnQSPqqnx5Gvqj4vz7nmeVq9pKinFZcLpsf8J2iDAh2GSZWVGKSQ7ZPrKEYaKHRIEPR3IMVWZtytwsgcHiLAasyhOEqCR4IA1SSfKNU/zErwHmpuZlSmzRpVoI05HJlkJNWL2HRp+QWOp1/BcOhO8Xb3HAKLK1Ey1vcx/AwCTRKIYnknND0TSmNaqzIUO//1zjkBvhu7VtFlm5bfVWsGco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(36756003)(956004)(16576012)(54906003)(2616005)(186003)(66946007)(966005)(83380400001)(4326008)(66556008)(31686004)(6486002)(86362001)(110136005)(5660300002)(6636002)(8676002)(31696002)(66476007)(45080400002)(316002)(2906002)(478600001)(38100700002)(53546011)(8936002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEljMklRd1FTeGI5TlA4Qk9xN3E1dEhQc3J3N0FqQmFkTmF1SXU3YmtZNU53?=
 =?utf-8?B?YjFYZ2FqbkIxSy9HQ0l5VmczS0c0VjhwUERiMGdCemFXdGFmWkNIbW1lTGYx?=
 =?utf-8?B?ajA2TWxhdTFmbkJKaG83WXcyeGJ0bWJwM1hkaGpPdlpWNSt3YkFmN0lhUHFn?=
 =?utf-8?B?OVMyeGw0NUZSSDArNDBiMGwrYjFpeU1ESmxvcXdxcnQ1eWE2ZEYwNm1Ybmor?=
 =?utf-8?B?K3lWNlFkUkZsNXd1SDZQL1NqUjkxbWh1K0JvU1FHWTVYRTlhb0hadis0cXZ4?=
 =?utf-8?B?cDhMcVI3Nm9Pbk1pbW1scHBKT3dVbi9uNXhocyt0aHhsRTlkMUVmdERLQTlM?=
 =?utf-8?B?bjJTTHdoN1M0UUJvMmdScDRiSHI4NzdaSVN4ZmRsTTljMjY1b0tocHlGSGZH?=
 =?utf-8?B?MWc1aXZ4elNXeEN4ZTFPeC9xMnprdFEvdXJ4dXQ2WUV0SERmNEFyVGZ1cW5l?=
 =?utf-8?B?TjVRbzRjMzhQTUNUTURiK2lFU1dMUWhZMDkrRm4vNFFWZ1d2TFhsVUNmcEM2?=
 =?utf-8?B?V3EwVHlsYUxRQzROOW1jY1paWGdHSjRST3o3TkM3VEV5OXJOYkVIWXRDTzFV?=
 =?utf-8?B?Rm40dW9nWTA3THZvRnMzQXZKb2RjSmJHZ3MrSjdmOU9uNTNGSE9rbFNTNkNq?=
 =?utf-8?B?cCt4UG9kOE14NDF3SHRDa0VwYVdyM25lTmtYSGkrZldKZzJYUXM4RTJxd3Fx?=
 =?utf-8?B?YnVJRUwzdGlIQzhWVENaOXRXVFk4L00ySExDZXFNaXVFUzcwYU9HQ3lEU3JT?=
 =?utf-8?B?SkZKRkdUODFldGtJV0xNbVNTSkxsb3g5Y2tBaWxjcjZjTEcyS0pKVENtUmVZ?=
 =?utf-8?B?K2ZrcjF0UGQ2eHdPaGJwM21XL2JEL0VXV1U1OHFrdlJnKzFOMUkrREZCS0Mv?=
 =?utf-8?B?K1hZdXQyNm1nZm80cWZoSXl2M3JaQis0UUR1czQzTk1IY29JUWp4TGMyZ1A4?=
 =?utf-8?B?SGdVMlBVcWFCUEgxenYrVHdpT3FBUEUrZmZmTjE5WE5paWVJbG9qR3V1WkhM?=
 =?utf-8?B?V0pxWWpnbXFZZWFPaGtka0hRZFNjRFQ4N2tKcXNVWFNpanZhUjVvWkhLTWlK?=
 =?utf-8?B?a3RMb1RVQTdGbDRoT2oyZnIwT0h0cTAvSndKYmhGZWF4VmpzWUlqRXZKMncz?=
 =?utf-8?B?YXIyeFdTbWR2YnlnSWlLZWdrWXpPNGZEejgwSTk0ODFqbVJZa3BuMFlSVWhJ?=
 =?utf-8?B?R3U2RC8zZEFKZ2VMeW5ZOGFSQng1YmQ1M25jM3FZODRRbmxHenc2c1B4OGYr?=
 =?utf-8?B?bXY1Q01tZzRkNXhJVXE1Zi8rb1B0aVRyMXdiUEYxUkQzNk9McWlJdmlkZzBF?=
 =?utf-8?B?QkJWdlphWUZpK1Z3WmNMRmZhWVVNWFZMTTNwOFFlcXo4VWtxQ2lzMjZ6TXZ6?=
 =?utf-8?B?d3ZTQzZaaDhhT2g0dXBDL1JTTHM4dWdtYlMyLzk4Y205WllYMFk1emJyUnNp?=
 =?utf-8?B?TjAxUVVleGdreWlETDIxRllOTGx4WlV2VG1hcGl6N0ZINk5wQnBsZ0RZaFJX?=
 =?utf-8?B?alhkMkpSYSt3S0gvL200cVVCb2VWWXJYYVhTVjVMUVdMcjhOTzZOZCtNRlhp?=
 =?utf-8?B?ZktWUDNLV0svLzNjSTJiMDRpVVNiSmg0dFUzODFUT3hXMlA5MS9TTUFLWThk?=
 =?utf-8?B?WCtWbUJzeHdQdlZTTzI3TklhSjQvbk0zTjdrajArUitvNStpVlRDYzRNNUdX?=
 =?utf-8?B?QWNzaGxQcGJzdXptNDc0c2pxT052VEFKTVRQZm5VcGVUVEZ4Y1o2cUdKUWZ4?=
 =?utf-8?Q?lkIpsNdDyhCArnRYsxnl6dJfLjGaHE/WZPL8qwm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3049e8-f270-4817-2233-08d97205c75b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 13:45:39.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO/xl07D0I6kg95HEMZhrQXRUaEMPhdVXiRe3IE+64Et0gfPDE3tEhgMmhRGe+LERjRY6QOX4GkvNOBEVYdwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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

On 2021-09-04 10:36 a.m., Mike Lothian wrote:
> Hi
> 
> This patch is causing issues on my PRIME system
> 
> I've opened https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1700&amp;data=04%7C01%7Cnicholas.kazlauskas%40amd.com%7Cd230db90a08d4b53011508d96fb15eb4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637663629862006687%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fH8mvhyHDchXqxZ5dlsyp7KqrzxkuymV%2BHtBmzVUD3I%3D&amp;reserved=0 to track
> 
> Cheers
> 
> Mike

We don't create the workqueue on headless configs so I guess all the 
instances of flush need to be guarded with NULL checks first.

Thanks for reporting this!

Regards,
Nicholas Kazlauskas

> 
> 
> On Fri, 13 Aug 2021 at 07:35, Wayne Lin <Wayne.Lin@amd.com> wrote:
>>
>> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>
>> [Why]
>> PSR can disable the HUBP along with the OTG when PSR is active.
>>
>> We'll hit a pageflip timeout when the OTG is disable because we're no
>> longer updating the CRTC vblank counter and the pflip high IRQ will
>> not fire on the flip.
>>
>> In order to flip the page flip timeout occur we should modify the
>> enter/exit conditions to match DRM requirements.
>>
>> [How]
>> Use our deferred handlers for DRM vblank control to notify DMCU(B)
>> when it can enable or disable PSR based on whether vblank is disabled or
>> enabled respectively.
>>
>> We'll need to pass along the stream with the notification now because
>> we want to access the CRTC state while the CRTC is locked to get the
>> stream state prior to the commit.
>>
>> Retain a reference to the stream so it remains safe to continue to
>> access and release that reference once we're done with it.
>>
>> Enable/disable logic follows what we were previously doing in
>> update_planes.
>>
>> The workqueue has to be flushed before programming streams or planes
>> to ensure that we exit out of idle optimizations and PSR before
>> these events occur if necessary.
>>
>> To keep the skip count logic the same to avoid FBCON PSR enablement
>> requires copying the allow condition onto the DM IRQ parameters - a
>> field that we can actually access from the worker.
>>
>> Reviewed-by: Roman Li <Roman.Li@amd.com>
>> Acked-by: Wayne Lin <wayne.lin@amd.com>
>> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++++++++----
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
>>   .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  1 +
>>   3 files changed, 43 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index f88b6c5b83cd..cebd663b6708 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1061,7 +1061,22 @@ static void vblank_control_worker(struct work_struct *work)
>>
>>          DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>>
>> +       /* Control PSR based on vblank requirements from OS */
>> +       if (vblank_work->stream && vblank_work->stream->link) {
>> +               if (vblank_work->enable) {
>> +                       if (vblank_work->stream->link->psr_settings.psr_allow_active)
>> +                               amdgpu_dm_psr_disable(vblank_work->stream);
>> +               } else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
>> +                          !vblank_work->stream->link->psr_settings.psr_allow_active &&
>> +                          vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>> +                       amdgpu_dm_psr_enable(vblank_work->stream);
>> +               }
>> +       }
>> +
>>          mutex_unlock(&dm->dc_lock);
>> +
>> +       dc_stream_release(vblank_work->stream);
>> +
>>          kfree(vblank_work);
>>   }
>>
>> @@ -6018,6 +6033,11 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>          work->acrtc = acrtc;
>>          work->enable = enable;
>>
>> +       if (acrtc_state->stream) {
>> +               dc_stream_retain(acrtc_state->stream);
>> +               work->stream = acrtc_state->stream;
>> +       }
>> +
>>          queue_work(dm->vblank_control_workqueue, &work->work);
>>   #endif
>>
>> @@ -8623,6 +8643,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>          /* Update the planes if changed or disable if we don't have any. */
>>          if ((planes_count || acrtc_state->active_planes == 0) &&
>>                  acrtc_state->stream) {
>> +               /*
>> +                * If PSR or idle optimizations are enabled then flush out
>> +                * any pending work before hardware programming.
>> +                */
>> +               flush_workqueue(dm->vblank_control_workqueue);
>> +
>>                  bundle->stream_update.stream = acrtc_state->stream;
>>                  if (new_pcrtc_state->mode_changed) {
>>                          bundle->stream_update.src = acrtc_state->stream->src;
>> @@ -8691,16 +8717,20 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                                  acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>>                                  !acrtc_state->stream->link->psr_settings.psr_feature_enabled)
>>                          amdgpu_dm_link_setup_psr(acrtc_state->stream);
>> -               else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
>> -                               acrtc_state->stream->link->psr_settings.psr_feature_enabled &&
>> -                               !acrtc_state->stream->link->psr_settings.psr_allow_active) {
>> -                       struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
>> -                                       acrtc_state->stream->dm_stream_context;
>> +
>> +               /* Decrement skip count when PSR is enabled and we're doing fast updates. */
>> +               if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>> +                   acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
>> +                       struct amdgpu_dm_connector *aconn =
>> +                               (struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
>>
>>                          if (aconn->psr_skip_count > 0)
>>                                  aconn->psr_skip_count--;
>> -                       else
>> -                               amdgpu_dm_psr_enable(acrtc_state->stream);
>> +
>> +                       /* Allow PSR when skip count is 0. */
>> +                       acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
>> +               } else {
>> +                       acrtc_attach->dm_irq_params.allow_psr_entry = false;
>>                  }
>>
>>                  mutex_unlock(&dm->dc_lock);
>> @@ -8949,8 +8979,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>
>>          if (dc_state) {
>>                  /* if there mode set or reset, disable eDP PSR */
>> -               if (mode_set_reset_required)
>> +               if (mode_set_reset_required) {
>> +                       flush_workqueue(dm->vblank_control_workqueue);
>>                          amdgpu_dm_psr_disable_all(dm);
>> +               }
>>
>>                  dm_enable_per_frame_crtc_master_sync(dc_state);
>>                  mutex_lock(&dm->dc_lock);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index c6b8b835b08a..d1d353a7c77d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -91,12 +91,14 @@ struct dm_compressor_info {
>>    * @work: Kernel work data for the work event
>>    * @dm: amdgpu display manager device
>>    * @acrtc: amdgpu CRTC instance for which the event has occurred
>> + * @stream: DC stream for which the event has occurred
>>    * @enable: true if enabling vblank
>>    */
>>   struct vblank_control_work {
>>          struct work_struct work;
>>          struct amdgpu_display_manager *dm;
>>          struct amdgpu_crtc *acrtc;
>> +       struct dc_stream_state *stream;
>>          bool enable;
>>   };
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
>> index f3b93ba69a27..79b5f9999fec 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
>> @@ -33,6 +33,7 @@ struct dm_irq_params {
>>          struct mod_vrr_params vrr_params;
>>          struct dc_stream_state *stream;
>>          int active_planes;
>> +       bool allow_psr_entry;
>>          struct mod_freesync_config freesync_config;
>>
>>   #ifdef CONFIG_DEBUG_FS
>> --
>> 2.25.1
>>

