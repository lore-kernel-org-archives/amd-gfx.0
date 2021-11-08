Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02142604DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02142604DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BF76E8E7;
	Mon,  8 Nov 2021 14:14:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A286E8CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyvMuR3Nhqrnas1u7hUNO6PUDIPczMTWTKS8dzdG8T3cZjY+iKOdpmB5B8kXfwVbmOdOzDjqOxcLLqVniqatYeHGt0VTs0Ulv1z/XInWFvRIjpvFdkRrhRqcLkymcZDeFZi5uJxgaCDNIgVJJRr4HlVVMcXWS1SpPa4ZeGlfWoCaZyZg+kVMo2XNkD//9Nw26hWP/wacvatYWrFGnAF33sLGOthyxxg6vW5akHtRm/Hpbu8FpInT9iYUpcsiY1/ciKiQ91g7or9yJHhr146yrhn69WX0FXSZkSzgP+O27wFvtYaRheZIM2xzgAMMjKOSVDlULdilbXpKFa3VvOXB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+t7SB1N0A3B0r10T/rTe2gnf7UpxfNv/OZrNZgSp0g=;
 b=SiwvuWXxEYxzqN/koBgUGJlr89fcGv6GaA1itClcgC1qk9pd33OTPq2XXj+tml0W7LrU/uZRpzxpx5bnAQrypUxG2Wv2aNwxxXKJFZgr4/jMKh+ThED2zDuTXDaJchbIJAmYXpljsY77yvge1nD5KmMZm8FpsFSNDUCuwgiha7GdWgKvyFTncTEz9RQ38tnSxhVJrPTXr6x0Z4p/13Uz1ICSpAhTmDeMtUpB19eN16mYvMSs5tGYxs2o3wpD24Ax51NrTtOfnDvf2zSI+10S51Gw2gXMWliLGnGlNWshsW4Kd8YoDe4zH6E9dDgqcg4/cKQoH5W2XeNwJv1o4mnKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+t7SB1N0A3B0r10T/rTe2gnf7UpxfNv/OZrNZgSp0g=;
 b=CUf6IZcv9dbvQZGDmuXwTwIDvXqSjMNyh3QuXyDxpwjjsAWhxN8hSLxlHKoZ2VcyaX57Q3TaGgYxEnnizRzyOPtf8+asGTDQqGPr4OYsiuWiNIDre4PTmf7/TMD+rSD/sGZD3iy+kWLSiQSKAzwToEhAquYkHwmAjKi7ezso2fY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 14:14:36 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:14:36 +0000
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
To: Borislav Petkov <bp@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
Date: Mon, 8 Nov 2021 15:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYkGteomN5Cbh1+C@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0053.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::30) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:308a:d18e:268b:408f]
 (2a02:908:1252:fb60:308a:d18e:268b:408f) by
 AM5PR1001CA0053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 14:14:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c046af57-52b0-4292-6ccd-08d9a2c217dc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0192:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0192FF6CA3E2DA14634BEDD483919@MWHPR1201MB0192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9LxfxJCD9Qow21zky2cu9TglXtBMlIrGJwd+ndqd0XzODwfb38+nECEgUgxRqukGIQHz4c3zkWjiVsC9LEYpe1EdWVaOFeUprgqRrjXq6sP/aUdMnP6wHbD3Vt7CAFsemrv4zjaq+pzt7tiFqOgob6dXMk1q6p6ihVAIxTIibVfxuJRwuo1siJ6ff8+5ORgnLDJJl3sdigSq/HE0y1VpZRBGHNz3zYk4hW/3TW/88V6SDE9C7fKS4ONMRpMNyFIoPkhxzsEy5epl0VVwb+cHGi3BTFpXlotTlaLQPmmoQYDzAvOxXVc7hI8GdtEfEubDy8eLgR/9/IZMnK3Uv/PEDI9CZx+qdoDw0F70HY7Y6fcEmoFGSyfN5zx2uPiWfsLx9+ZIYUiDEhK4Qa6Xoo95u9slZVrv9BBLfSv30xMFhLBoD1SU23bU8SZkXFbYT47+iBnyRIepVUBnjS5XE7ZMnEgpWdfFORTIqlz+1OukAg9WIC/4hsiLjU6adGWUEq2j3DjL/QbYhhAePbV9RgRdrSfeiWMuIj+YETrdrNl+Lfr8hV8B0Mipnw2zFmJ8yN0x6GAvBL9IT+oiaPa23FHMDe+xP5T0ZsxC3v1tZKId2BSU5aBib5cZ2eJBWXLGi/c3aR4NxMUHaA3QdRvgMNuxCd6DILSYCvuypLUKsQOaZD1OWLttjuWPtSWdVS+IKlWIG4L7BoGhyeasF7PvtSPkLY4immmHCTSugYONwYTKwYZxNQoc4aDH83PsHxzu14Wsh1FYkUXC+qm+uizVqLm5PnFvhTPa6SJmLVKPqJUoomyfJM1LNf+kqs2NqGF/f6V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(6666004)(966005)(4744005)(31686004)(6486002)(8936002)(31696002)(8676002)(316002)(186003)(5660300002)(110136005)(4326008)(508600001)(38100700002)(2616005)(66476007)(66946007)(66556008)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFwdXBJNytUbFhmRVNZd2VEQXZzNnlmYXlPanl0eCtyVit4Y1hBSnpoVzBQ?=
 =?utf-8?B?b3hERGlhbWQ1eVplbFBmTWhPSFBwMWpEVk41TitHcFFMbGorOVg4c3RLTGlE?=
 =?utf-8?B?aXlRWjkzbXE4blg5QjlraWkwOHlrc2Qyd3huVjA1SFlEM285RXpkYWNDc1E4?=
 =?utf-8?B?MEpnSjRuV2ZtQ3ZlaFAra0N5bDdja1Ftc1JGalZHN0tHUzVJL3IreWtwaDAv?=
 =?utf-8?B?Qi9NUStrZlRjc2psR2NDNTBOZ0VBcHJnd1VCT1BHWU1QNWRoZmZmcnlEUFBz?=
 =?utf-8?B?bmU4NElHYnlQSWw2dHpsaWRUbXNJam9ScTZRbHd0V3Y0OEYxa3cyQjhXdTlI?=
 =?utf-8?B?WG1ndXBGM3BaWVVGdCt5Q0ZkWEpSbnVXUVg0bGJFcTM2Mk82OHM3M0VJN2dB?=
 =?utf-8?B?Si9nNzk5enpFMGgrR0ZmVlBRYlJZUDIwLzlFcGQxK1dnVXNrSTI0QlF5WEdZ?=
 =?utf-8?B?QmhaVGE0MnZFUUdnUUtZQml0TUpqMnlCdWF1VUM4VnpTTzcrWTcrNXhGRnBF?=
 =?utf-8?B?VWFTejdFc0hGcUo1OWF6WWpMNDJVa0dOQXE2cnFIUmdDK0ZCWFcwQyt2UGE3?=
 =?utf-8?B?Qyt5eXVEaTltZ1VtWXJCTmhVcDlIeVEzaXhKSTZybGpQb1A5eHVVbklPMVVF?=
 =?utf-8?B?WFoxb1cwVU45cjFRc0g4RlZETUdXclJhSlhKTHdod1FBR1RxOGdCRFhaVzh5?=
 =?utf-8?B?YmtiZUg4Q2hBNm1iZVovODFUZ3JjSXZvSnZoV1hDNG1VSUJPNURENmlBWDFv?=
 =?utf-8?B?YVdaWHZxY3FjK1crNHN0SlFid0pQOFY5bUpsaytiMUx5cGpIeFVaZnRDQit1?=
 =?utf-8?B?L3oydm80cTQySkxTZ2FKMHFyMVUxZWx4ZzlXNjAxcWVyRnFITms3NWxGSUo2?=
 =?utf-8?B?cjJvVzZ3WFBnaGhvbmU4c25wU1NTWDJGNy9kMUZ5Ym1lc0lrUXArS1dzUlpZ?=
 =?utf-8?B?WTNsMmZpVWNmZzlNWDBMZ2lHM3Y3S0Y2M0F5bVhJbGo5SS9lM2Z4WlFBbloy?=
 =?utf-8?B?S1JKTUxBamw1VlBXRnF4ejVzZkZUc2tCWUhWMHMvSnhXQ3pTNDBzeHJjMXg2?=
 =?utf-8?B?ZXgvd1hvVjJTMmJTUGMyYzhLM0wrdW9FU1pCQ1oyT2dkS053RVBVbEZxUE0w?=
 =?utf-8?B?Rm1reGhad081K2lERDRvRlFFa3prTEJEMWd4UjMxZ3N4UHlDazlwVUVDR0Z2?=
 =?utf-8?B?aHR6cmYyR1dvbU1pMUJBa1Zsems0aTlUbWFKQ0ljdVpsUTdZcTcvYW9ySG9U?=
 =?utf-8?B?M0FkbkVoVXhaMjZETXh3djJ6N0Z2bWZKTERtakVwalNFVVpobnFnLzlaMzlE?=
 =?utf-8?B?RjRQNU8ya3NBWmF6NWVMTC8xVU9OTHVDZGFWcng1dThCcFF3YlZCbG43UkQz?=
 =?utf-8?B?VUdOZmV6anZ6clBzVzZsdHB3RkVwUFN2QzJkRzA4a2tRdDAvWE1hQ2U3YlhS?=
 =?utf-8?B?eDZmK3B4ajl3TUhRVGdlOVpWUldvWjFZRVRLbnVDaFhMSGUydTliTkJRUVNR?=
 =?utf-8?B?WStyQUhORHFpdU8xRzlwWUlVdVJkNjZPc1F2V3ZRQWxiM1RpTGFxUVhjUlRC?=
 =?utf-8?B?OExxY3l4bVlrV1RCVVc1NEt5YlljVStaTjFvZ2NsVjJTKytxQ1VRYXBLeWZs?=
 =?utf-8?B?aUZYakFMUVZaSVVEYTJ4SmhFb0FYUk03LzNycktla1Z6NjJkRlgxMjBMWWhP?=
 =?utf-8?B?RjdoTjZaVGlQSTQzcklFQXNWYmxsSUFibERjZmk5UjVyS0ZGalA2d3lIK01D?=
 =?utf-8?B?WVA5eGxBdCtYYWhzUUFycUtTVm1RU3NJazgvelkvVWkyaHg2cWZEcVZnVW1W?=
 =?utf-8?B?ekxBaktRT0U3aEdScUh0Y2dOclNrM2hNdjk3WUNVOHNaSXY4V2tFQVorYTNl?=
 =?utf-8?B?RTV2Lzh2ZFFENjlVc2ZFWlZCK0FLWjVqUGdZQ3pPVmFYZEw4azNvMUwvNjEr?=
 =?utf-8?B?QWp2Z291MFFHMzVsNG1kOXFZRzJWeXR5Z0xMWGtTM2lCVW1MTWdWWGRtdlph?=
 =?utf-8?B?bjZKNDBhY2JzWElGcUJpWmxSOW1pTlJJbEFTbFlESE1xNW1iR3doanZVK1k2?=
 =?utf-8?B?TnFGbGNTMVVUeU1TZ0ZJNzI1K1VLelpsZXdlUHI2NnBXMUFMTWhpeFRGSlZU?=
 =?utf-8?B?U1o0R2o1UW4ycFZCc0V2b0I5OTIrVy9pQ2xiaU9vcDVJMTJtK2w5TFg2WVFP?=
 =?utf-8?Q?yrmcPclj6WziLebgLVMv+cY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c046af57-52b0-4292-6ccd-08d9a2c217dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:14:36.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8YQTYODYqOHuf5q2w5F78gO39MAkoSmsvRi5Aqg0WsIWnO/aQb/vlEj8DXnUNPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0192
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 amd-gfx@lists.freedesktop.org, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.21 um 12:15 schrieb Borislav Petkov:
> On Mon, Nov 08, 2021 at 09:51:03AM +0100, Paul Menzel wrote:
>> Please elaborate the kind of issues.
> It fails to reboot on Carrizo-based laptops.

That doesn't necessary sounds like a good idea to me then.

What exactly is going wrong here? And what is the rational that we must 
fix this by avoiding updating the current state?

See we usually assume that updating to the already set state is 
unproblematic and that here sounds like just trying to mitigated some 
issues instead of fixing the root cause.

Regards,
Christian.

>
> Whoever commits this, pls add
>
> Link: https://lore.kernel.org/r/YV81vidWQLWvATMM@zn.tnic
>
> so that it is clear what the whole story way.
>
> Thx.
>

