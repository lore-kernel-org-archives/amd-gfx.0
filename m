Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 10:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA53661215
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 10:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA53661215
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3F6E9B9;
	Mon,  4 Oct 2021 10:43:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1BC6E9B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 10:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSQAbYUh5hx3U9MGAkKIYyREhd01apZ7TrtVij1afbSLspIsEv71nbbGoMF+J7UrnpwtZVAMQYVJT96ij6BleY4V0395nVVpn5JR+2JRs5AJXb+A9cTlrRPDnH11013KHBhok63msSDMKqn4MuR0GHHV1pnWa6Bi4tqeLjIktDoamZ4aqFTnwTv3STnMlT65zulEyJN+nDdsU7DAJMeIHaFoaLHxcY6I4EHT6ZRapYaqzJPjjEyPCmYxCHYmUFZnZaFqjxSSVCDc9tBzgrjJdoIJ1JrQolRhSr7h80QlV/8VjC++hzDYmo6V8ID/B2W3KjfeW60nwzPMkB6U8joKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOEemTXkyg5srhs7jcc3sPNcL1CvoAmzQSVgar3+pJM=;
 b=ZnKROmAf0LUlXkSUCZkgKU0+G57tHWcsQFBJfWW0OQA9uBKxZCmVMTK5e/b2+DV0St/7uzH3GOgZq5szIewiY0uLEe1fSI1+PQzTrfwn3eFl3sahkuXmU/Rxh4FdvmEuK1zyh3Hmbp0MGPvO9YHHw1OUtdJVcgYAdzWo+sBiTXKm8hnC1npQK8cPORtl/sUrUPmRL/+SdXF1oPenurQSzJLwjdrL/WpOE/MwnNw9hL5xQG2KBBms3GunR6FWSfbCy9NuH5Tzk4vbNJ1aA/jjF6t38wSRjJgIHXCDoU/TpGX5HnZE9wz9qcB4Z1uBDXyYA9dUYlN2tPzO6rog0nnuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOEemTXkyg5srhs7jcc3sPNcL1CvoAmzQSVgar3+pJM=;
 b=Rm/PYE2CSWtwDKuWsQ8vrWIPljze07NfG1luA1qbuwrzczddT8nXGmJjXnCue1j19wjXBWr4WBciyUbJXvCcjuJt0Q98LswqS4c2xDDkzr9b+LLbfhFTLH81dCMqQkuD/JSpF7AlTgDeI6jNF5GRxGGqNsZE0/l3zSmT1gWNb3w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 10:43:19 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:43:19 +0000
Subject: Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power limits
 in smu struct
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-4-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <d3b0d32c-0c14-c5ff-4157-501599c502b5@amd.com>
Date: Mon, 4 Oct 2021 16:13:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211003044658.29238-4-darren.powell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 10:43:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ded029-47de-4a49-bba3-08d98723c77a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02011C5D24420146C14BE45D97AE9@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgg2e6552H4xmmUzukWacKHvaWsNZJfY69wNuG6pO2OTdlifwOOW8dq9hWz0s6n7HBs2TTsVNWob8Jp5FBkPcPc0KxWE5Eyz43REnOiWuB3DujDd3ZJcAW6ewZ18ObsMi6t0NKfc7+iwzADc7U3tR0SzsvwQ1Qi9P3LTiAho9tyfzUSvfjiaIoK0vz0fRfvP6pzB6f7U72U2dO/l0rv9FTygNhKTPJtiLXvVaKXpqFKIbDFsDbY7VqDLY6QZmaXrrCRORbl9g7w5qHqrqRT3Hmq0FrME9g0wgKW8Sz6aoptu9xXfovL6CGCzdrrEIc6webItid625TRuIHAxyT69NbBFAAGD9FK+Lrc65FO7naBy6yl4eSz3f11ZCSE7rfFtUP+DwN4mCv/OW9Che2NvZ+IRXYrN4dteykgbdPPB7YmprWnC9XxRjgM3WcApwrDC7MQXeV5uv1I+KdAnjwljIv9OaFZklpPtjxC08lBWK2AGCQk4Qf1UN3MIbkOvkbiMLqVi5wJgSwPqI4bwv9KLdhRITB8k7jXL9JRcJZCuNuRMQtl5jGTAnkM06jpOTzkDtZdgCpPtGuT3lh6YwqAM/spCdMXXtO4Yofka5R/qmji59VXfOdU9+2uUT5//y+QxdP5d8Zp27wDG9MI4HQO36eBRlhqfdLNsUD66P+c3MI4HxVly1yNdTO8f5P3cKLMNg0klV4PogTof6oLcvaVVmZkkh0UXLzrCa/3JGkljDWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(83380400001)(6666004)(86362001)(4744005)(2616005)(5660300002)(36756003)(31696002)(956004)(38100700002)(2906002)(66556008)(66946007)(6486002)(53546011)(66476007)(186003)(31686004)(8936002)(316002)(26005)(16576012)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFPbHpVQm9UWndWNnRYYTNiRjFxMHFtS1kxZFRJdEdKUVFWb2hRbjAwZlB0?=
 =?utf-8?B?TVlzazk2K1RiSGJRV1VCNE9SeHI3WVBkMkw4eTdvMG9xajNIRFYzZm5uZlA5?=
 =?utf-8?B?bVZCNlFDQkV2ZzY1eTRUWHA1M201L0x2MjZrMkxja2IwalM3MWNxTW83MHBG?=
 =?utf-8?B?YkhnWlZ3UnFLVEphbzE1NXFCYjEyTGZEYW1yZ2FWbm5DVEJpYzcrWWpHWmxs?=
 =?utf-8?B?a1FPeWQrWC9ua2dSZTlWcUY2SjY0TmNPWjdIcWNIWnlGYkxzV1QyUFVYcHZy?=
 =?utf-8?B?SVNIQnNKaCs1RDJod1FQSGtxS0x3aDQzMG9DZjNXTDFOOXJlMEEvVzNLS0NJ?=
 =?utf-8?B?R3dEQ25naWdpbTFXMWduYWtNSS8vQ3hTdndrS2QwOFdBTUdzV2M5MVFPYUEw?=
 =?utf-8?B?K080MXBsU0JUa2JRSzVBbzJxb0FRZTQ0TXhiSGtLNjU3UHBzQXNlR2ZtNkow?=
 =?utf-8?B?YTNQY2JTVlhYOGprdFdJWHEwRU5tc0RjaURMVVJlc3VtQjNQNXVQL0FXd2NW?=
 =?utf-8?B?VmZuL0NJRGtRV2drdU9TVE91SlhFRDVGRFEwOFZzMWo4RndCQ05XaEIveU96?=
 =?utf-8?B?c1BWd2NJRUd3aWNRYkR4QTN4WVdQOVJGU0tsRGZOb3k0aWxyTkd3dlFCNEN3?=
 =?utf-8?B?RE9hQ1hrUno0Q2haR1ZmdGxZUnU2cEJxRnlYOXY0dEZ4SHdaSHdOZTNENTY3?=
 =?utf-8?B?NGxJNng5KzFDL0RxbVhObk9Ga2MxMWxvS2g1NVplQklGL2xwNmV3ait5U1cy?=
 =?utf-8?B?OFNOR0FNT2llSG1wdVFwcWZrR1p0SUpXS2UySXJtSjlSY2FhYXREZkhOeVl2?=
 =?utf-8?B?OHZzRHFlSjcwMUNxdDZmRWZrYkg1N3M5N1FPbFBJaUtYYXlpRy9SU0lQakN6?=
 =?utf-8?B?bS8xNTlhMmJUakpDN2F5dHpkbHc1aHdHUVpsMUljMUQ2Q3o4a2hUMkhSUThu?=
 =?utf-8?B?TCs2MDFvNDF5ZWVtanJqMk91V3llN2JpelhmU3U4SDhwZDdrbndjQlBYcHFh?=
 =?utf-8?B?eEdjd3ZtZnpML3VqeGluR01TVXlxcFZtNmd5eWpad2tLQitIa3ljcUJGZ0tk?=
 =?utf-8?B?a3gxTDhXeDF0ZFZQVkJOaGpWM01VVjhDbGFIZGRFU3pyYjhmVWdWa2NzdW83?=
 =?utf-8?B?VmRja1BVdnE2MmUwbVN5eGZ6c29pZVJVWGQyQnBSbEhQSWxmeHpxZk43U0Jw?=
 =?utf-8?B?TkVPQ2ljV2oxdmhSV1lnZVRQTTBydkpNUlhUTEs3bE9ER0RySTZlZHJDanpG?=
 =?utf-8?B?RXhyaWJHeUFrWTBKUXREYTJFaEFNbTlXdTVONkgxUXYxeG4vMEVJQjVNdjVp?=
 =?utf-8?B?YWt5UmFkWk1KM3lWQUZTdlE3VU5wVjQxV3RISFl6U2VqVy82eENwM3hyYkFD?=
 =?utf-8?B?NWdFdlFTa3V3c1FjZHNaVEt6dFdpRTYzaTc3Vm5RclBMbHk3d21WNmZiUUtH?=
 =?utf-8?B?TTJBNzVlbFpXaitCVC84bytFYldSTFduYTFwK2gxZElMWlhteEFSbzlNQ3BM?=
 =?utf-8?B?R3Bidlo3dnhTUVgvOE16WEdhUGdjYVNYUmhoOEhXNDRSQk1qdHZhcjJydTl1?=
 =?utf-8?B?VFZUYkhQQlczYXdpc3ptSkJkLzFMbTg0eHhiVTlTQWlUWG1tcC9iYVhCYTFT?=
 =?utf-8?B?MTVXMXkwNTc0cXZWdlM0cS9BYUJOMWUvWVRIN2R3ejR3L3hKUnFHdUxXdEhU?=
 =?utf-8?B?S1F6S3g5elhoWkRoVE1vV0QzMnZINHRnYThRalk4RnNLWVI0UnlQdEsrYkxE?=
 =?utf-8?Q?i+w3QA4uPv/JUo3b9p4WBQx7yAJ+XrjffSKIbFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ded029-47de-4a49-bba3-08d98723c77a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:43:19.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJfzA0Vq8lI+l0gLSO38DU9XF5MO9yuMEf60IjgacCWR9EUt94gsk0VEyf9yDKKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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



On 10/3/2021 10:16 AM, Darren Powell wrote:
> Code appears to initialize values but macro will exit without error
> or initializing value if function is not implmented
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index faa78a048b1f..210f047e136d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -712,6 +712,10 @@ static int smu_late_init(void *handle)
>   		return ret;
>   	}
>   
> +	smu->current_power_limit = 0;
> +	smu->default_power_limit = 0;
> +	smu->max_power_limit = 0;
> +

If this is only about first-time init - smu_context is part of adev, it 
will be zero initialized when adev is allocated.


Thanks,
Lijo

>   	ret = smu_get_asic_power_limits(smu,
>   					&smu->current_power_limit,
>   					&smu->default_power_limit,
> 
