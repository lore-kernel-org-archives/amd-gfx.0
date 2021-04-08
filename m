Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7405BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1875261108
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1875261108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F6E6E2C7;
	Thu,  8 Apr 2021 18:02:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FAA6E2D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 18:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baun6mhGsYGHs/bVgjd6E1UwOrYCRJ8SVY/MtxRtyRUQQu5G7iUQ5rOSO45re9kX2YxCTrQTFC/1SKP/QhhRlyicteuKz74jAjQ8gdUIV7Bj1V0IocxFN3NObMCnePf97ywfCwYsP2h3SRTVOU65+IAEZfd2ykcNQJL4fkS8W7L+l9BFM2cd6yMPsKEzG6lOFyyEGF8ootZ5Q0dFfGIdxJ4s7OTlNZm+QIn1h3cwvJwxGC9EImrsv/jrYeul9A082xkpmI5rk0iSpdxPN98KvvgJLNBnoAorN2vCGC6xjn4ZSygN5gvGq9rejafmHThWfDhfVsv4Wl5k8RRAezU3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgzV3/v8chLm3ciLqh21qOLrX29cPZdK5f4L+WCMKzE=;
 b=PRubJXEvfCnPouW9kXuFOBu1NEiNOu13MCfi7zTUtE47Ova0zqyNlnt1JJ44QzcsAeWF0TohFlj+w+Anq+pPtggkWhsLKQJJ6jsfESSgB+Kr/QsZuRexRxhl2OkA3xPMlwcEDn8X793OQLWgwL8LYtYcRzdVRINZMclJMoo3zyeVj/seYYpvgGcy0v5zNmaynEy3LfHMsXz9AUYW3CH0ymXitwMBDiB0+uicRQojJog9gtTWwFc4K7tx2CFV/7g/Cl8FMcIsrATg0nZqCjRQSoA3JBj8syl10hdpIT4M9BLaqNiWyTz8MSOKLjNxIJTWl5OMsK52AtCzKnrUwhNcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgzV3/v8chLm3ciLqh21qOLrX29cPZdK5f4L+WCMKzE=;
 b=tpSqWq/mp/LG8RueNNWFZgl7JA+58N+hNL3MUQMB+HZzfThGdUMA5IF0SYIKakRzWbnLg3QX26S4AFwb4r7VZ6YvNHH8zmnfyfJB16uSg/iRlkcVT7CsO/uAYSS9C3fragaRb2DeArTkjNqKWoUii1a7acC4uv9ejn+cJadwZfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 18:01:59 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60%5]) with mapi id 15.20.4020.017; Thu, 8 Apr 2021
 18:01:59 +0000
Subject: Re: [PATCH v2] drm/amd/display: Update DCN302 SR Exit Latency
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210408171048.44591-1-aurabindo.pillai@amd.com>
 <f72ee3b2-fc36-bb41-4c15-09f22a683d77@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <9d18a98d-a23f-2976-0a3d-be70bded81a7@amd.com>
Date: Thu, 8 Apr 2021 14:01:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <f72ee3b2-fc36-bb41-4c15-09f22a683d77@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.1.132] (165.204.55.250) by
 YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Thu, 8 Apr 2021 18:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67544ba8-01c0-4b77-7177-08d8fab86756
X-MS-TrafficTypeDiagnostic: CH0PR12MB5139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB513921AE0CB306D9A3E882858B749@CH0PR12MB5139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tnyoySqgOxcCtt4UV0rAFZg3xEV5YSs+lG4V6twW+inJeQHe9yvHqPcK9rWmSQC7vFnWrFq1lPfh4Nf7QEH8v1W6EvlQdztVkDdRqHTYMkb8NvgqNNUVK+gXENtafFgbsQqfpHH6TS61esrPlfeot6WuzkB/hb6Jar1lTVk0WLc+yi9nqCtjciCvOotL26Vvc2ypx3AJQX2gqcOvLl7pI05WKHrCqNKjLFyAT+eHuswbE83H6Cm1qs/waFsw1svtqmBdU14Qylu3QCq8OQ0i2NjpiH9yOF19UhH57v36MpEhUf+C6gsmNFSjIJiHc2xInNHoFROlBvKF4tllzg4umkdrVKRazxiFB9HTUu1zXBmt3gQsjBzhM3tW7sdz5XmuDxUAF7A11DZX/Qcj0ybXYKGrbROUwPrpI45e6Z2RxzXCcMErVm1u80kkLEhh0dQM/FgXLfdsfVtYFkAwn94lfajRi9t8/hY9sP0+Qn8k1ARUOxFFWxaLIOOXOcP03BvsD+xqEUjReuC3+Z6DAbiQWOiKpMaZ6HhNBJq5JEUO31SvkrV8pfO3TYi5HN+pRTiDS+pHxvDHVhdGS/nPYbF0i4lPvYww1T+GTraG5ucKtOZ/J5uMgnMQMfxhvv8xit1JfE8xvy8LQPEqGwUa6Dmiwi1i7BK27ifpNSZCgTSjlOH3jzaclrLhasn5Ux1Sh0pvjaIEQmYSalXJ0wIKkqqOWll+q9xjQR7u2ZQtHbRbUo6u7dTASyzFy4fyDZaMlnj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(38100700001)(44832011)(53546011)(38350700001)(15650500001)(956004)(6486002)(83380400001)(26005)(478600001)(2616005)(4326008)(36756003)(16526019)(6666004)(66946007)(186003)(316002)(2906002)(31686004)(8936002)(8676002)(52116002)(66556008)(66476007)(86362001)(16576012)(5660300002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2ZmeEhSSUg4UEoxVGluWVgyUGtOM0dlVTBkeDRITEQrZXVSZ3lvWngyMWh1?=
 =?utf-8?B?ejF3cG5kWUlvcE9lQ05RMXJETU9jNWdLR1lKNXpSRG5pSXUyS0tKWVVLWXVS?=
 =?utf-8?B?SnhMQVdhL0pueW5LbmRCM3Y2Ni8rS2ptNmk2NGM1cUVNUlcwTlY1KzF2aFFG?=
 =?utf-8?B?aGxScHpNVXNXMmNrekhyaUVJRVJnWUVjSWd5V1FJdGdCcVl0T1Q0SUpRcmtq?=
 =?utf-8?B?V2oySS9peVR1SU5sWXBzRVFyRE1UamtFRmUzcGl2S1RMQ0JGZHZPa3M3Mzlu?=
 =?utf-8?B?R0pvRERnT3dnZERHdkpNVXRja3cxUGdkZ3k1SWMzTmlvUFV2clZudTdYMUNl?=
 =?utf-8?B?YmRxNmFtRHVOVDYvVS81dUFrdWNmM3VxbU5pYVF3a09OUkZFSklrcE9icXEw?=
 =?utf-8?B?NXZBRVp2enpNQVFQaEh6dkQxcGVXcm03dmVwaVRvNVFpakd0d0tDanE5a0J4?=
 =?utf-8?B?M0dxNTQ3YWFXU2dVQkk5Nmg2TWJzMmJ4WHFNdExDTlhIL2h2QUR4bmlwRDlG?=
 =?utf-8?B?bGxlZXA1NlJOeDJ1UGx5YndqNENUTXcwSElHUXgwemN2Rkc2eVpUTncrQ3By?=
 =?utf-8?B?WGFNYm1PNDdhZEJpeEo5RW1zZDlyWGVXQkRDd254ZStjMm9jUG1PNTRXUlNN?=
 =?utf-8?B?SzhNaFBmQ1NYYW15MEZLL1pjeEJpbWVjT3dEMDl5d3VnaS94U05OaXlzZlhr?=
 =?utf-8?B?eEJUbDM3TzZXTTVXbVRhYUhGckFoQ2dDNjF0VTBsUkNFc0hwTVFUVTJkMWE3?=
 =?utf-8?B?aW83SGtja1JHQ08rREFLaFJmVmxrTUROZW9RU2hvQmhNUnkxRDZIOVdXMnVY?=
 =?utf-8?B?WWtTVDBSRCsrcmdjaW5aQXpQZnM0SGNySnd5NXNyZzkrOHloZ05HalV2UGNi?=
 =?utf-8?B?eXg0VnRNb2FjN1FMU2lhamJUcDhZMTJHamdtZmFBV1ZtSksya1huYU52M2Qx?=
 =?utf-8?B?aGRCWXlRcUIwTTd3SmJQS2J6OWhEcytyeC8vQUVDd3ZuTkFxU2tzS05jSGVU?=
 =?utf-8?B?Wno3UXRPMUVRL0pITDRLME5Oamx2aCtGMDNRNVdRUWpRZGNnOG9KQXp5Y0Y2?=
 =?utf-8?B?Wmx5RGgzK21rcXZBOUo4SzNVL1NISmhaL1A4N01MWEt1NHpBZVVjaWZ2Lzk5?=
 =?utf-8?B?dUJLVlM1MzZWaEc1QjlHSVpmN0NNcjdWSUswTEFZOC9nL2M2OVlMbDhWNk42?=
 =?utf-8?B?OCtBM0FtVzZYUUlNRktGQVF4SURvdnl2aU95MXFXY2pLQnJNNFBETFBJSnNW?=
 =?utf-8?B?VFQ0bGo5Wm1LMEdpaEI2cVFHYzd5aGRMR0FCMmJpL2U0Y2ZrUDBaVVFpNVdR?=
 =?utf-8?B?S0VySjJXaXBZSUdqSUVBNVBRNHJoRFozWnJYQXQ3Z0lRNkQ5ZmhWSnNXWmFZ?=
 =?utf-8?B?YWtSVWZ5ckpXT1dEMHpVODR2ZUp5NXltY3hzTGc3RDQyM0NTNXd4K1RyY0pQ?=
 =?utf-8?B?bTRQUk9YT0ZlclBON0llYU9EL3ZkbjhqQW5qVFUrOTJkNkdTeW9TNVFvdEVk?=
 =?utf-8?B?TkY3dnBnK2FkQnpiRm9FcWs3WmxoNmwrSVpzTWJuRG5XeC9DcXcvT3dFaGhu?=
 =?utf-8?B?V3RHZ21DSnRRR0hnSUN5bXRJMi9aMllhWmRMd0tlMTFkeTFVOUtNU1gwSFJ2?=
 =?utf-8?B?ZE9sNEhVa1hTdXBieWlJcWNaTmhWQ3ZNS2hqeUNud3dubFpvcW1rSkp5c004?=
 =?utf-8?B?OEIxYW9xZVlVeW9jQ21yU0JLek84T1Iyc3ZUQU05aDFORFBFUi9XOXY0L3hR?=
 =?utf-8?Q?/sciesuampPcS1mPa9ahq1l0qbBqNHzT1W7xh57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67544ba8-01c0-4b77-7177-08d8fab86756
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 18:01:58.8635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG8tUZXx7T/3X4+FiWTTdSEBI8d80OzGR5IwgnLUO48511TrJHX++CBc0es0GoFieQRjhCVzuwbxnJCH6s3Eag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
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
Cc: Bindu.R@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IEhhcnJ5LgoKT24gMjAyMS0wNC0wOCAxOjQ2IHAubS4sIEhhcnJ5IFdlbnRsYW5k
IHdyb3RlOgo+IE9uIDIwMjEtMDQtMDggMToxMCBwLm0uLCBBdXJhYmluZG8gUGlsbGFpIHdyb3Rl
Ogo+PiBGcm9tOiBKb3NodWEgQWJlcmJhY2sgPGpvc2h1YS5hYmVyYmFja0BhbWQuY29tPgo+Pgo+
PiBbV2h5Jkhvd10KPj4gVXBkYXRlIFNSIEV4aXQgTGF0ZW5jeSB0byBmaXggc2NyZWVuIGZsaWNr
ZXJpbmcgY2F1c2VkIGR1ZSB0byBPVEcKPj4gdW5kZXJmbG93LiBUaGlzIGlzIHRoZSByZWNvbW1l
bmRlZCB2YWx1ZSBnaXZlbiBieSB0aGUgaGFyZHdhcmUgSVAgdGVhbS4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogSm9zaHVhIEFiZXJiYWNrIDxqb3NodWEuYWJlcmJhY2tAYW1kLmNvbT4KPj4gQWNrZWQt
Ynk6IEF1cmFiaW5kbyBQaWxsYWkgPGF1cmFiaW5kby5waWxsYWlAYW1kLmNvbT4KPiAKPiBSZXZp
ZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gCj4gSGFy
cnkKPiAKPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMDIv
ZGNuMzAyX3Jlc291cmNlLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjMwMi9kY24zMDJfcmVzb3VyY2UuYyAKPj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzAyL2RjbjMwMl9yZXNvdXJjZS5jCj4+IGluZGV4IGE5Mjhj
MWQ5YTU1Ny4uZmMyZGVhMjQzZDFiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMzAyL2RjbjMwMl9yZXNvdXJjZS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMDIvZGNuMzAyX3Jlc291cmNlLmMKPj4gQEAgLTE2NCw3
ICsxNjQsNyBAQCBzdHJ1Y3QgX3Zjc19kcGlfc29jX2JvdW5kaW5nX2JveF9zdCBkY24zXzAyX3Nv
YyA9IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5taW5fZGNmY2xrID0gNTAwLjAsIC8qIFRPRE86
IHNldCB0aGlzIHRvIGFjdHVhbCBtaW4gRENGQ0xLICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAu
bnVtX3N0YXRlcyA9IDEsCj4+IC3CoMKgwqDCoMKgwqDCoCAuc3JfZXhpdF90aW1lX3VzID0gMTIs
Cj4+ICvCoMKgwqDCoMKgwqDCoCAuc3JfZXhpdF90aW1lX3VzID0gMTUuNSwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIC5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9IDIwLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgLnVyZ2VudF9sYXRlbmN5X3VzID0gNC4wLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LnVyZ2VudF9sYXRlbmN5X3BpeGVsX2RhdGFfb25seV91cyA9IDQuMCwKPj4KPiAKCi0tIApSZWdh
cmRzLApBdXJhYmluZG8gUGlsbGFpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
