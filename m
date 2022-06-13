Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A106C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 17:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9230010F4FF;
	Mon, 13 Jun 2022 17:55:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870A310F4F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 17:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGOFtia4m97Gsu651DxLiqMvZiGebajCvVC6suHOsP58UYXZEmwRm6bUFNZ6k7wLSbkP6dKfb4kZBw5WNfHVB/Yr53dyMcOqsGTr7vJmepXDsP8NaU0YRP+qjOb9fTj/5nOgWEHHEIeFcBKSptwcupcfU3m3lpDMd2VMo2I6JJH1Jl9pImgAGO7y5FlDdlbR/Vs8Ydsy/0D7GZjkIx9eVguk40cnnDFLjFlxhqJuuTKi01U/Nwe8jLAFHWDACy733ze4edtzkBL6VHF6ZBAP7L0irGXGQOrpPsCKcCKEbwiVLHIqctpy6AASSnL9uFw0tdrA1RdXC4Sq2ZfRyCaISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feipjhBGf86RxpCQol1ZmNgQa+XBSPdAAPLysKMBMQI=;
 b=ISdNwn2vy6N3M25Nk/dyLqBMFWFdW/4+AgDMs4JO5RHOr3YED6xOmkKFIiHfNe7S5shWUTj7uU4IRXGlHNubX2rmSdk+BEtkNhTLhAChmMh9wyerKhx4ukRMVFNjYhSUNju4ibEtDMGowkrrtCFlFuAxnDE8cwi4527PerkPyTauE1yxO9p1GHpQLG3Q46agjN2v/Q+dmgv6NmTOP4wJWui4BacS3sbwh4ykyvlMUlSaLoVAS1FuV4s1ddcNWU9EfdHtBAOQ9pOR2+W2qD4qJC19Ogpx27ZQ1S5lFr5TUx4JO7vdg39gNN5R5S4mcq8/bQ+a0MpqXjjxcvWGnwE8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feipjhBGf86RxpCQol1ZmNgQa+XBSPdAAPLysKMBMQI=;
 b=jjEXSt+LO/YWpZP4DE1us8oakQirmZg44Ztw67oqo0pmxVFszC1omzx4lMQmCTs/RL4fJ/5m5fYEHxgry2QlTr1tCN2RN/FFq9ldEF/XwjFpa/fFSKnbtU437DLrE+AnbcSyj6JJb6zZ6V+rDa9TQ3C6Ub2sHEdOFmaCQGaa/TM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 17:55:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 17:55:44 +0000
Message-ID: <467bf0af-5967-63bd-97ad-4b3fd105fb9b@amd.com>
Date: Mon, 13 Jun 2022 13:55:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Content-Language: en-US
To: "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
 <DM6PR12MB425031A66132DF5CEF04B0B1F4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <DM6PR12MB425031A66132DF5CEF04B0B1F4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106212bc-e717-4c9a-4c53-08da4d65efa3
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5968DD53956D200F31153F2B8CAB9@LV2PR12MB5968.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyjwRjYGpPzMjMkENKNmhztUivLPd5aMKUFUYohvb1Ms/wtjYb+ogf0duIfGhYHw1+Ut6vHlbQfTWu05Jj0bMchQSWW9FQ2ZAo+OLnuNMuTbI+m/z3mlSt5DEQ7tb6epaisgI/4/Wp2U7Ywi+AvYfdAQXw74D8O3Fg1ZPxqFZEz65JlDGvEW/GneTIRgTTeeRaW1GgMl3VB8PKK4VaN4BbYr54jdq5++58r5fnCBgvjdB9/FWEGWKo6wom8l8YyiNOA/BnfllUdqxtOUjuyYwTyESriLyrhY6iRXKredMU+xshTw/Rv/HM2xGxypAvoz+CDlzcGJfsBG2pPUqDD/XDz/AqRyl9k55sD8elreXSi+UBsEFV/X7aH6j5vCQfKKOvMxRaKB26Asp6III9j8N0g7/omZUY+tCA4XOtzLu3TTk1igytqHZH2I/WRTeq6WqZ7NR1s2KHj7p+AHApzYpF3mxa8eGJ0/I8kuCSSnzrp5xKk+wsaUlfYHf6auVVWKmiC6jRzwwGVwEcwH4izLo/hK1MIxOpxjUfTw7uU4Pa6+vzXhcEvO1DVZwIuGYLh/jPGhY3cAfXAG83e5wHWpuBwM/jA6yb/n9Nm+ump1ZvUki7fdHFCk7ijq4GGRvofSRM+XQ7PNbyfodCwuCKjqjl3TCMx2itn2liu8P8TxmdmKX4jCzE1tyULm7RBe42LkhaOU8aVetgOqHnBs8t/K9YWLjqQMflcNiPhBcLIfw+RMHVozCfMx8byNuwxZv8mXxR7UN97E/4YaCvewOHfWI+ATkMpKiBdoCky5AROhHh4n6cNf/t0wdwFIo31xIXlhFpiWCYHlveZ6bOtMhT7BjUt17PBZIEJ+UxAMWkVqrRMlyiXOyySxu+xCY/lIWkQa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(5660300002)(66556008)(66946007)(66476007)(2906002)(508600001)(6486002)(8936002)(44832011)(66574015)(6506007)(86362001)(966005)(53546011)(6512007)(8676002)(4326008)(38100700002)(6666004)(31696002)(54906003)(26005)(316002)(36756003)(83380400001)(31686004)(110136005)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWN1bW9KK09YUXgrWHllV1hxV3huRkFjdS9TRnZ4bVdRSlZ1dDFNWTZTOWc2?=
 =?utf-8?B?VG1pRXd3aituMXZSblVORG4zbEhYSlEvYWw3dWw1c0lneTB3VnZBbUVWc2Vz?=
 =?utf-8?B?YnlaZlZyWExTcEFabURTOGxLSFZmbFJLSE9maXRLSm9UQ0E0UjJGMDJONkhS?=
 =?utf-8?B?ZTFDSXRld0o2alc4U2NNMzdUUkkrUXI2ZHNaVEUzTnF4S1hsR1dUWFNBVjV6?=
 =?utf-8?B?NDhqeVVVWjRxalpWUWRscWNRTWxoMHc2VEt6Qk15c1BZN3QrZjBNSDZhcTc4?=
 =?utf-8?B?blJ6NDNNQ2RLZkswbUpkUjhneHVjaTMvUE1tbHVXMm9oQUY2Tm5haE12YjRz?=
 =?utf-8?B?ZDd3N3FkajRhb3VLY21UWlVEYjFRSzVkMGU2dU9STGFyMTRuUE5EOHFITCtS?=
 =?utf-8?B?NmFhell4eW5xbXEzQTV4QzFQZWdzd1BSdUpVcTdxMm01dVFNSnJ0blZ2N0VH?=
 =?utf-8?B?TGFTTlhMcGlTbitZKzNxSmgra2N0OCtWQXdLbERDUXAzcW56SUx1c1Y5U3Aw?=
 =?utf-8?B?NW1yTmpvSXB0eXdHUEt1VFA5RlVSU1NCZ1RoUks0OWZISU1LNy9mVElDUmpB?=
 =?utf-8?B?YmJvT3J6SlRrTUV2cVFaRkgzbGt1VFFWd05ObnNSMm1LMFczeDZoQzhlYzhx?=
 =?utf-8?B?emlLRmh0Wi9DeGh1aWZ3TlZqVjB1VXg1b2Zld0JRN0NLbEV4VlFIZE1ST05T?=
 =?utf-8?B?QVZ6RFQ2cUIydm5jb05YWWI3MlFDT0hweEhqUVRkUTFzK1ZmS28vTU4rU1NB?=
 =?utf-8?B?VVJJZ0dPQVVWQnRxUU9ZUlBvUFJScTgyNTV0VmRNRmt6blNPSzAvaUVuMlBL?=
 =?utf-8?B?VVlkQUVPZUNNYVk1TTJNMHpNL1NjaGZoekxSeGJGZjdVU0ppc1doVXNXYUp1?=
 =?utf-8?B?RlZqTG9GK3FGWG1ISU5GNjhnQlkxdXVUQmhPMHJhZmE1elhORzM2SkJ2RFhG?=
 =?utf-8?B?T3VWUUtRQ0JSTFdjNFlUczZoT2k4MXBVRm9pSDBLNFI2dWNhWGZ6YjNRZFZK?=
 =?utf-8?B?ZHcybG91WCtORkJnNWZaK0JBUWhxd3NVTkdQM1l5OUZ1OTNteWV1V2NMaTkz?=
 =?utf-8?B?a2dLbktHM0thRm1PeHJoUlpaNi8yanlYUjlTdEJiMURKM1hLbkVxMnFQTlFq?=
 =?utf-8?B?Qjl6dHJDKzlpd0N4RjdOY0t3ZDV0RHcxQ0FtQmJYeDZBUDRsSlAvcXJZS3lj?=
 =?utf-8?B?MnUvRmh4bm9kR0lwWGkrZ2FVSFA3YUY1eTNINnVqazlWcEpNT2tqLzRHMWNW?=
 =?utf-8?B?aU53K21TRVJYT0JtcXV6dy82Vkp2VnFmUitpdmhMTnl6dUZpK1JySzVqTTlM?=
 =?utf-8?B?RXM0TWp6Nzg0Uko4Vmh5SVRHUXFOSFE3SWx4NjU3U1JzVXNrWk54bzQ1NlNO?=
 =?utf-8?B?M05FZFR6aW01R09hMngyQ0RqMlM2MDZ5bmptWHp4NnhhWEZYMmloTGoxcldo?=
 =?utf-8?B?NEc1MXJLSndaRXFXUjFEcjdOUzdlTStJMkloMFQ3Q0FIQVlwYjNaZE5YM2k1?=
 =?utf-8?B?VUZSR0t3dC9zUlluQnYrcnd6TXd4bXdsVjBzZVVWZk5FWGZXRU5IK0FBaHZz?=
 =?utf-8?B?L0JIMWYrZ0t1QmpvaVQ4TExoN2N3RjQzT3RBTElRTzluakJ5NVVzSG5UQURY?=
 =?utf-8?B?VzVUYXE3OXVza05raDRSaUlySVhKcmVCMWtETGFGeTJvUXRnK1FFbTFLYlJZ?=
 =?utf-8?B?MEFLS2lpZDhQcUR0eUlMNCtRcXBhQm82UjMvWXRzVjk3bEg4RHRZSDlsN29M?=
 =?utf-8?B?R1F5YXhkc0F1Z1JvUnMxRm5NdFVyWEt6bk15YTc5dDhmU0pORTdFdmpPcUta?=
 =?utf-8?B?WGdaU2J1blEyRDRaWi9qNVBzaW5udHVrM2NubWZxU0NrZkhzc1NabkNJNDRo?=
 =?utf-8?B?dGg0UEhWdm1hSndZeXdtMGZHSXpRTnFhSnNabkRmQU5ZMDIzS1hsbTZySmRJ?=
 =?utf-8?B?VVVLTEdSYWQzTmpRWGNNWGEwQWpGd0NSQndaL0V3RTFnZGQxQTdiVHBZR1dr?=
 =?utf-8?B?Y1VLYW9vaG9BNTZQanVtNyt3UWdLWGQ4K2hWK3hXTHFmY25xQ01wbU1DaTNK?=
 =?utf-8?B?ZWt2K3ZHYnMyTTIyTDRsdjgrWnh6MHhGMU5UaHhzR3g5dlAzZjdLOFpGekx0?=
 =?utf-8?B?SDkrWVh6cS9MNk5vUGxucU5EVGg1SW9QOFkxSHhqTzFDSHlyTHRLNlBaaXNJ?=
 =?utf-8?B?SG1DVkUwVnI5VkkvZXdqNVJjOHhFaFhsR0ZBOC9EYXB4VThLQ3hrZjY1WHph?=
 =?utf-8?B?M1d0Q1BnaUVoZU42Q3ZEbU1kWGxSVTlRUlVBMWxTUExybFVLbk12aUNLdk5V?=
 =?utf-8?B?KzdITjRvNzRqY0F3QVJKRzkwcnRsQlFmcHN2aG1BWlgxWHhDY0dXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106212bc-e717-4c9a-4c53-08da4d65efa3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 17:55:43.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTLZXK4cG2Bybhma5GUXLhROLGa5DADjblSm4FhkwtRTjLnrL3sQRNCte071EXWajWhef6pAiKZvC02NhRRduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Clark, Felipe" <Felipe.Clark@amd.com>,
 "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This seems to be a case of a Windows-centric commit description that doesn't
completely make sense for Linux.

The code-change doesn't currently affect any behavior on Linux. It just lays
the groundwork in DC to allow an implementation to do a memory-clock switching
decision based around VRR support.

In short, this won't be a problem for us at this point.

Might be better to change the subject line and commit description to reflect that:

"drm/amd/display: Add vrr_active_variable to dc_stream_update

[Why]
The display driver on some OSes need to track it in order to perform memory clock
switching decisions."

... or something like the above.

Harry


On 2022-06-13 10:52, Vanzylldejong, Harry wrote:
> [AMD Official Use Only - General]
> 
> +@Clark, Felipe
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: June 13, 2022 10:34 AM
> To: Vanzylldejong, Harry <Harry.Vanzylldejong@amd.com>
> Cc: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>; Michel Dänzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; amd-gfx@lists.freedesktop.org; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock switching in games
> 
> It should be noted that FAMS is an additional feature to enable mclk switching in more marginal cases than would normally be possible.
> 
> Alex
> 
> On Mon, Jun 13, 2022 at 9:32 AM Vanzylldejong, Harry <Harry.Vanzylldejong@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>> Hi Chandan,
>>
>> When using Firmware Assisted Memory clock Switching (FAMS), when the
>> memory clock is switched the frame rate is dropped for at least 1 frame, sometimes 2-3 frames to make the V-Blank long enough to handle the period where the GDDR6 memory is unavailable when the memory clock switches.
>> This drop may be noticeable by gamers, especially if the memory clock
>> wants to change it's clock rate several times a second, which is what we observed just on the desktop.
>> To guarantee best game performance, we disable FAMS during game play.
>>
>> Harry
>>
>>
>> -----Original Message-----
>> From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
>> Sent: June 13, 2022 8:42 AM
>> To: Michel Dänzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza
>> <Hamza.Mahfooz@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan)
>> <HaoPing.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha,
>> Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Zhuo, Qingqing (Lillian)
>> <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
>> Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
>> Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo
>> <Aurabindo.Pillai@amd.com>; Vanzylldejong, Harry
>> <Harry.Vanzylldejong@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;
>> Wentland, Harry <Harry.Wentland@amd.com>; Gutierrez, Agustin
>> <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
>> Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory
>> clock switching in games
>>
>> Hi,
>>
>> Can you please elaborate on why dynamic memory clock switching can affect Game performance?
>>
>> BR,
>> Chandan V N
>>
>>
>>> On 2022-06-10 22:52, Hamza Mahfooz wrote:
>>>> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
>>>>
>>>> [WHY]
>>>> Game performace may be affected if dynamic memory clock switching
>>>> is enabled while playing games.
>>>>
>>>> [HOW]
>>>> Propagate the vrr active state to dirty bit so that on mode set it
>>>> disables dynamic memory clock switching.
>>>
>>> So dynamic memory clock switching will be disabled whenever VRR is enabled?
>>>
>>> Note that there is ongoing discussion about how Wayland compositors could usefully keep VRR enabled all the time, as opposed to only while >there's a fullscreen application like a game. So "VRR is enabled" likely won't be equivalent to "game is running" in the long term.
>>>
>>>
>> --
>> Earthling Michel Dänzer            |                  https://redhat.com/>>> Libre software enthusiast          |         Mesa and Xwayland developer

