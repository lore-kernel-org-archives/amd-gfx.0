Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD71C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DEB61053
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8DEB61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551526EA0F;
	Wed, 13 Oct 2021 16:22:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6744B6EA0F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll31vYVaJynDCGuLblrZrbgD11YsfQ4w5d4phUOo+783ce6wowixmm53DjBeHfCR3e3x0Z+hFweoao1uH/wn4lt2gIqafW6royd8bgr5zi54bVEkTRN3DskgQ8HH3gm1t7C88bNYyf6zlME3eDmXEA10dYSJUX26H22oEeYkCLhVaf1/z+qvmqT3J9OiVslMr0/93hrECJnCwjEtsISJxkYf+WVJAQs9YNYEl5m1NwdnG+0Lraya9u+D/kcpq3mHLhOGigmeQ3WLFA3Ge5Kenf/0fu7tSCmkFcRuGJsuxMDD9bikFan/ZX/xT9eWPybM7cVa7o0WSlT4MDpJWeblBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWU3UkrQidBPrmzC/ZRprAJoqe+euadd097qtYBk1QA=;
 b=JbHtorwnBpjlcq/0XIC3zZdex+8+HBSAHhzogsyElYJNBNunJM7Gj8NuKF8V1nhgyKuTCkha1U0k+eUifJW6S00a8VNzifoQ8q863s5JQfD/juhAsSeeQEZoH8Y5J9anfG48VuT9AprXAaBaZP7++bL8tJg/+ZBlWGzHHJWxvIKGjSSak9435gZ0NYvl1XgoNdzprkFO2A11KA6tFb11k79I82ODa65h9xhP9dtN+RKdnGAX+kNPfMRqbJ1+nnGkNkMADqU9PRztBvdRcavofNc30bTOJo8+XjeZZFK/iZPA/hmM9sgl1NrlLYxsH/scaoLy7avpCrSXDR3riWebLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWU3UkrQidBPrmzC/ZRprAJoqe+euadd097qtYBk1QA=;
 b=HIfpE027m3TOouxUcOrtUk4IdejAfdugGP7iLBYAwilvZxX9PiY0OBPYEWvs+X3hOvXhCQpWrEu8HcKR83MXZksSLZtqigct0H8If/v428eRAdRqFdvu0fxAuoyhYzd0549DExnqxsTSAye0mSCId6ufL4/NQZzBSaKIAwgaaZk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 16:22:12 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 16:22:12 +0000
Message-ID: <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
Date: Wed, 13 Oct 2021 12:22:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Content-Language: en-CA
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [172.31.6.39] (165.204.84.11) by
 YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:22:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04713959-27fd-4101-beba-08d98e659cf2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748A5403C7564454C019ED499B79@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KmiyqCOGjy5TR8uvX7W21SJxh3kGo5ePCr/VgMIErYwuYbVkEv3xByEmH0/ez5jq29h9Wkms+GyTrcvfc74oWIHZVqVpX9JeVucZlemvT3KZnJjISeCEjWc7bTpV7ZApID0I8ju6bNHIev8cz83Cyw1hxTo8FYp2FljxBOr/mI39+o/IlngzDPBFJZJbrsYfID/t6196XqdUyKHjxh7X1lJq3F8t5FL//H5f8Un5X0Crtjp1EkfzymOk2VAniJdFCRwHl4UyMQ+CBAEgtqBi/J5KtBwsRBdqIb6nuSGMM99FMCc3ihqfvvw5h8jR7pw7FFSjLSyN8FRGzClnWAFFgxeRRiW2M5UX2qPCN0t+j8kiacHQosM2nNMQdcWaRqzL51aIWo9KVDuxXltVzdCJFmFRT02raSykYOPNS54sLc+5YbM9c87inUuN+CcRp+L5b6eucSH/jeQCiQb8OeHSQr0Pvg/J4xBaG0MCOXvVbsZk9dzlayIas8P3/iZRIG4wZikmkElkLQMo8nL+hRUcPZ1lIZ41yJveG2F0pLEFASQseNBIDzIO0pR/y8xV/p06MAs+gq0EvCUinnBq7EhGhA3VZ6IVPXDKsblHquI/mQDEQhs+5CvLfZtqYkxxiWTFEtoo3/i72Q0pLubwhclM/MAEEctKtwEW9WbOG1aXEDAC8fF0B+S2NuVBZzstmQ7y+FpHRNlwCeeXZO96TdxjXfNmo+p73AWTBlPs6CrjN63g1lnMevTp8vBxga13wP4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(66556008)(8936002)(6486002)(44832011)(53546011)(316002)(66946007)(16576012)(66476007)(508600001)(5660300002)(31686004)(186003)(4326008)(26005)(4001150100001)(6666004)(31696002)(2906002)(83380400001)(8676002)(2616005)(956004)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEh6WHlPTlB6THhxS2s0WWlMTEJRZkluVTIzWTZkc1NFYnRFRDAyMHVPaTBR?=
 =?utf-8?B?NGRnRS9DY3hsbDU5WDQ2R1VtQ3RRcDJYa3NaMlNZNXNBTkt5MW9ZL2lyeEJY?=
 =?utf-8?B?eUs5T1R2K045VmJreWtKUndaUHRIM25NUzRoMW8yUkRIdFc5SDZUK0FsMitN?=
 =?utf-8?B?MnhDc2tJU1pKNndhdCtRb1MyUUw1UGg2UFVvQldhU2NTczlkQXlEenZUb1BB?=
 =?utf-8?B?dUk4THE0K0dTMG1OSkNnUUgwY0RvNHdxTHJ3enRDbHpVb0h5eEVyeGM1dE4y?=
 =?utf-8?B?YVJjTWJENlRzYWo1OVErZDNvb0tsKzRUS21RMC9ycVFMTFRQVUNla01ES3hX?=
 =?utf-8?B?cnNJZDJodkVPMGs5ek5mNitoYldCcG5ubU5RSU9ZVis3allYdVVjU3BEOGU4?=
 =?utf-8?B?Z2doRW9ZcENiYTZ5QWRjY3dBaGpsaGZHYlZoUXlWL3c1RE9Ecm9xUlFPSkpj?=
 =?utf-8?B?VUNoT1RmNHBrS1lzcVBHZ1JmWDhVSFNOL3pPWnF1RUtCR0RXUUc0VXdWcUFY?=
 =?utf-8?B?VWdWZDlzUkdiVkQ2VzZpU2lCMWRxNHhpQ09IdmFLMndvZDZFakVPUlFiTkgy?=
 =?utf-8?B?OWhiZ1FhZzVoY2Y5b2R4OWNJdGZJd1VDem5VZldMZjFLZHpVbTFucTkwVUZj?=
 =?utf-8?B?OXZ4ZTZuUVlCRzkyY3FackpxOUJyV0VoNXJWdDBDL2xKU0NtV05qQXlxK0Ux?=
 =?utf-8?B?Zjg2cEwrbWZqZTFXZ05LZ1A2NU1wWERDa3UyZWlMVU5FZlIyZEl4TzUvTnV2?=
 =?utf-8?B?ZjhpcWFacWpPd3BZQU4zSGtDQmlZSkZJdWhqR0MwTGZHL0lwNHNNdnNhVmd2?=
 =?utf-8?B?SnVIR3pOTG5iYmM0cC82ZWowcTE2M1N3dlRhK2xuR1V0R1doVjVCOVdxWXU2?=
 =?utf-8?B?b0pmb2dIQUQ1aE05WlRFc1lzTytXOHFQeWJIc2xvYkRxR05OTU9NMTBjN3d1?=
 =?utf-8?B?VnVsSVBTUEhhUWx4NTJ2UldOSGlVMWhFUTAxSUhGUHZWc0dHaitpUHVLSmxC?=
 =?utf-8?B?VEtmaDlhMGxncjR2QURZdXJYSGRzUU16RDAxRnJYcCtkS0dWS1Y4NFZJV09q?=
 =?utf-8?B?c3ZoblJaVDRZcmVIbnMvRXFkMEJKMC95ejl3ZHRob1E5VnhlMlFsNVhnM2o1?=
 =?utf-8?B?SDNPQlo0MmhjQ01idVJtUCtSRzE1RHB5c3VrZitGWTVXdmFxbmZRQ3Q0bmIw?=
 =?utf-8?B?aG1wLzR0Mm9DVyt1ZVh4U2FCVmxUMHRWYVVKMDVRMjdBWGZZVmtzMUJkenFq?=
 =?utf-8?B?Q2Rzd1pDMDdWYU5RcnJvd1VDYWZ5QURsTVRTTUZTUC8yWnhLQTdoVUdyY21C?=
 =?utf-8?B?T0FnVGdvZW5GY0pjMUZmMy94b3RBazBwdjlhWW1zUThiZFpJT2g5MXhRQnVO?=
 =?utf-8?B?cnVUUHVmcWVLaU1lY25FS09qa3RDRVRrekczbFRXY0lGcUF1REhoUUQvRU0w?=
 =?utf-8?B?Wi83Vlo2TUxDN21zN1RKQnA2MkMya1AyTm9mSlBCbmNPNGY1TWNjWlFJNkUy?=
 =?utf-8?B?c2lJVmdGTkxCNHRkZHdFR29VeUZWb2tMWnBZbGJqM04xcjVLMGJNRnF2SitX?=
 =?utf-8?B?dGJCZS91U1VwWkpSUGtoR2xicitDc0l4ekhUaG4yejk1eit4NnNXdEJFS1RD?=
 =?utf-8?B?dDVRUmlBL1lPRW5kRDc1cnRQdHZnb3IyTU1jZTk5UHozV2VVRVE4Z0JNZnFD?=
 =?utf-8?B?dlg3VGJqeUs0VVVCVnRsalR3NFJzVUhpY2JHM2dvTWRUY1ErZGtUWEQvSnEz?=
 =?utf-8?Q?R8uQBcOLOnv4N2VLbXdhq1XfCCHXl9wmZTrQvfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04713959-27fd-4101-beba-08d98e659cf2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:22:12.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLrQLH6NmE+rdTbmc1TWOwcDlL9um9/kgHtT9ZN+FB8THSRX5GIr4jWt8RdNm24M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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

On 2021-10-13 00:14, Lazar, Lijo wrote:
>
> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
>> Some ASIC support low-power functionality for the whole ASIC or just
>> an IP block. When in such low-power mode, some sysfs interfaces would
>> report a frequency of 0, e.g.,
>>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 500Mhz
>> 1: 0Mhz *
>> 2: 2200Mhz
>> $_
>>
>> An operating frequency of 0 MHz doesn't make sense, and this interface
>> is designed to report only operating clock frequencies, i.e. non-zero,
>> and possibly the current one.
>>
>> When in this low-power state, round to the smallest
>> operating frequency, for this interface, as follows,
>>
> Would rather avoid this -
>
> 1) It is manipulating FW reported value. If at all there is an uncaught 
> issue in FW reporting of frequency values, that is masked here.
> 2) Otherwise, if 0MHz is described as GFX power gated case, this 
> provides a convenient interface to check if GFX is power gated.
>
> If seeing a '0' is not pleasing, consider changing to something like
> 	"NA" - not available (frequency cannot be fetched at the moment).

There's a ROCm tool which literally asserts if the values are not ordered in increasing order. Now since 0 < 550, but 0 is listed as the second entry, the tool simply asserts and crashes.

It is not clear what you'd rather see here:

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 550Mhz
1: N/A *
2: 2200MHz
$_

Is this what you want to see? (That'll crash other tools which expect %uMhz.)

Or maybe just a list without default hint, i.e. no asterisk?

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 550Mhz
1: 2200MHz
$_

What should the output be?

We want to avoid showing 0, but still show numbers.

Regards,
Luben

>
> Thanks,
> Lijo
>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 500Mhz *
>> 1: 2200Mhz
>> $_
>>
>> Luben Tuikov (5):
>>    drm/amd/pm: Slight function rename
>>    drm/amd/pm: Rename cur_value to curr_value
>>    drm/amd/pm: Rename freq_values --> freq_value
>>    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>>    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
>>
>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>>   2 files changed, 86 insertions(+), 47 deletions(-)
>>

