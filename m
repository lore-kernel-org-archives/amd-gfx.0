Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9739C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D60F61B29
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D60F61B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36426E8A2;
	Thu, 18 Nov 2021 04:09:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973856E8A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 04:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFFdFDnJiUvA/q/uuW6Yj5ZHoydCcWUSTmZZQ40a0lcTuW0I9dLDy+TXCGQVVJEpajdRFsxMzrLHyAnMhpj95bZFPLMrHMUSE0Ka21OUQeFCdkmDBdmkTWqTkneHViDqrgAVsPlnFRmWfYPeDoh9FFXuOHLYxqPxOkzxm9xQKgvTFrA+s7d0dVoVs8Q53nRelyugy1b2lr3V4V/YOgX1AFqb6luijH+rsu0rpqGij2z90cf2HkWI87S/agvO3ML8aat6R1D87FQp0cTsnRTb4S0KfKglPjmqizfvq1GiD3lJ3W72VlCw5uo0GRFOcNK0QLQQubVMPhU2Z4QNrj6aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKs7647ie0d64KV+XvqzVcBs+0pF06DxKe2v8t4Qagg=;
 b=Xkg0ahQagtw55JAuDDb8XPfRgCV2b8Lph1D5l9/xJbDIP4mGBg4QX6WCtg9DXoo5JPSD/Pw0rj0Gz5Z+FpIEhrMa1yWfF15fuprZEYdXS5RIpeheT5JISybWpXFGcW7tnPLYiTV3BfXHoixUvzGk3iLtQcS4tKH9lNnDJe2vBOhwFs9NszRw45Pt9ZaIbYr322lx37YrxxC7uMPDUk0T7zBlvFpquBDGd0UV+RXAV6+Zk9pQmAC4XnrWVSzPfIksV2PlFWMZ4I/gvQNLZkvokhQRPe8QYP5wRtst/QG4S3TW5gJce1km6F6NDrtXKmgMPI/OsTw/vgsJf0T4GXKUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKs7647ie0d64KV+XvqzVcBs+0pF06DxKe2v8t4Qagg=;
 b=cZNwdTlPVGFH606WPK7JYtflXRP22RcZFnfGUyEAYio4WZvryqHq0MoyYI+XrwSMDlTQ89zJC7yl+7UaKlVsqBZDrv9VkNUoulMc27h6ItXj0KbPF+xNRAZgYWcTRlL43gmIJAD0xNYvxFyH+ZM/YYaEx/T/PzugAklANpbTePw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 04:09:54 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 04:09:54 +0000
Message-ID: <c780f228-c921-7a4f-0b4e-0b7572101ac0@amd.com>
Date: Thu, 18 Nov 2021 09:39:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIFJldmlldyA0LzRdIHF1ZXJ5IHVtYyBl?=
 =?UTF-8?Q?rror_info_from_ecc=5ftable?=
Content-Language: en-US
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-4-Stanley.Yang@amd.com>
 <8eab09ca-8294-a41b-d44b-fe6bbd84d727@amd.com>
 <BL1PR12MB5334D091D2231C60623949DD9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5334D091D2231C60623949DD9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::25) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 04:09:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd3817a9-5dca-4932-7696-08d9aa49461f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243991C05B9FF18C2696F2B6979B9@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8w4M9ucsNC2EuE/GMJzk99BHzfwWTB1CdJMuuIxah91dRsHx1ikyKPlwxYEtUI6bKbAMQ3oEEqkxKuKkQYaT8sudbkyis5Snuu1YHJKfGwL91+ZO7rylNggr5snqxJk7thjs6EgVLzt5QbOzeGL8yGWBdwjzq01C70+P5hGXXsNh+RAafQmR0XMp/LB3MM4Qdpe4WHRMFxp26nYOU7+ydGRwLPJYmBC+zQniMThH5cIdAlK+qT5ZJkMBAOZWgZJMD3xfdOZeU45L/dvrAP4eqCe5aN2wsdJbuuLeCSUySXGKvpWm0OURxi42nbeVVhhvms+1mbOLH0J5sjEhHmnYm/4w9cye3GirF4tqv4psYCuA91L3RK7CAGm2WTs0+sizXYthDoiFNRzypOFjfJr9w7KmYwilKqDwWufA36E/dlX2ZS4c8cLmzBjAOHZGZ5uujRO9SqiB0cMhILYjEmDcP6i3Z5OR9GkG1Fe9uBbduRte+ruCMBPmAGkdzwvUliTgURjt3TJbmJ7QzsIuB3g/SF2JGhhOeHNqAOFYbxWc4k0XxUXUX8PqCdTdJPWz3TJkhiF1ao1fplS3sy8cNw2F/PTPCaQsHo+2eKZERNL1I7nGEI/P5hgW1iS7w75hyMhk9EPU3xyW8rMjE2wYoSvz826rrHrNFCpWm64XxZTA+Pt4dAKfwN/ionFZM96oBzbKIXEKt77mx1VRJ+PWTo4iSfae94J9B2LAIqj4jhnviqmfxfSu4n890J4w4d9gWaH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(38100700002)(6636002)(31686004)(5660300002)(66946007)(224303003)(53546011)(316002)(31696002)(83380400001)(921005)(66476007)(956004)(110136005)(2616005)(508600001)(30864003)(6666004)(26005)(6486002)(66556008)(36756003)(8936002)(2906002)(186003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm4vK2RTNVZvelJaRE1pemViRlJEQyt4dGhmbW5zOW1zK2xSaWttaitLcjZq?=
 =?utf-8?B?STJMVnA2NWNkYStPek1CeEh2VWt3R1Y2b05STmNIMXBkUTlrM09RNXBkaEVo?=
 =?utf-8?B?bWtwTXhkQW9qL21UVWRuUmFYRDRxWXdqYkJhMlNPNWZ0bVZ4MXNITW1XM3JT?=
 =?utf-8?B?N2VGVHlYOWtxUy9hM2YrNGJJc1hjRjRaZDZ4dXdaeWVpYTR3NmI2VC9DejdH?=
 =?utf-8?B?eW9mNXVCM1NNQjlKUk5EUDl0Si9tS09qYkhEcFhzR2tOQmRJaTRrcVlNMlFk?=
 =?utf-8?B?K3dSU1dMQmtVeXhiSTdGRHRKM1JYWU42alhuTTJxem42RTlnTEZPY2J5akRO?=
 =?utf-8?B?WUtYT3B0SE0vSmFBeWRWZlFRRURRZFlwdUYzOWQxazVHMGQxb09oRjgvWmN6?=
 =?utf-8?B?cSsyU0Q5Uk93TjBjNzI3b1BacmluTUEzQk5BR29mLzd3c1h6OEdCTWgvNTh5?=
 =?utf-8?B?OVRtTGN0bzFXVVFJa05QWHZGS0V0QkxzRExvUjN6eWhLMHFrSmlBSmNpN004?=
 =?utf-8?B?VFhSZi84UVFMMTE2QWY1N1R0dWJORFBPV3Q3TFhHQUd5aFhaYkZJSk5IWnhW?=
 =?utf-8?B?MnFjYkt2Zm9hUzNEVCtZUUwrZ1Zvd0dveS93RGZPNG9yUFhRYTU4a0dCbXJp?=
 =?utf-8?B?bHdwZzRyNUhKd01wY3hQcm1YUGJxdFVVWCtQMDVwbW5NbktFTlBjeFMySkRk?=
 =?utf-8?B?dTM1L0E2cmk3VUJYTmhzVXU5NlVub09xeFE0Z2xOYkJUUnRqUE5xZWQ0ajFW?=
 =?utf-8?B?Z2Jjb1NrSzU5TW14M0Z6am4vUTgrU3BXcFhvaWZWejFqUVBWYXdlSDBPRm5m?=
 =?utf-8?B?L0k4bGxWb2ljanh5WGZDUmFKV2tnbHB3VjJ5RGZPZzh1NiszRGU3TUExZzJk?=
 =?utf-8?B?Wm5hUmxPQmNHZXhnMVFLWFpOTW5tZS9rVTdlaGI5VTJtaWhVSFV5Y1pKbmRz?=
 =?utf-8?B?N1pvNmJ4UThLTnFPcmhzQWMxaWdRY2x1N1N5MEg5NlpDYWwwQ0xtNkdkVkVK?=
 =?utf-8?B?N3FrRVA1Z0ZOYmhnaTRrTFR6ak5wMThRMkgyMFR5NjY4bU1BRVExazAyaUtk?=
 =?utf-8?B?ZjdKcjZrd3BBdXYweU42R09lYVlITkh3TFExek5QWUcrb3FjQ0hSTk4yK0dK?=
 =?utf-8?B?bFVXSmJIK3F2eFNlY0pLWEtJUnVCSUkxTmJEeGVJRjJFVXczbnJNTkg1VVBS?=
 =?utf-8?B?UGFKYmVFV0tKclVVRFFGVFlBd3Q3YXRZTGFNSE1TcWxqRXRHQW9oQTJIZ3cx?=
 =?utf-8?B?TzEwR0hNK2tBcVNvSHU1cjA4UnRRbXdESno1S25HbENFaXduVzJRZ1hvR2s3?=
 =?utf-8?B?aG9ySHdYVXJxTnN4eWN0S01hTWpUVHpJRDVZbm1nSFpqcWdJYTN5T2dyOWpZ?=
 =?utf-8?B?b3dBWDdLNmJVbEtpQnhiYkNHWVUwcVE2TlV1cFZycTJ2QkNST0wxQkUxQWN4?=
 =?utf-8?B?bFBrRDVWY3RsRGRZZis5eFh4UlkyRGJYaGQvNmd6UTRaZzc4MUYzZVVyV0dw?=
 =?utf-8?B?c25CVHdvOXlrdlFzUVVrcWg2UXRYYUxFT0ZTMEcwTXp1KzFVdWhjVzdzWUJW?=
 =?utf-8?B?Mm12ZmpDTTU4UVlYOWh6VitxVkI1RDJTNjFEcVpaaVpoR2p4Z2xsZVREeU80?=
 =?utf-8?B?czJlQXNSNWZiUDdObVJkT3NJK3hHVXlvMXBqcXQrSTJaOWczRkhTbkxtSkxo?=
 =?utf-8?B?SWJqaFY4aFhvV01Pa0ZZdk9UWTRqdS90aTQ0YTlhdjRvNGpvSFE1T0dUL3kr?=
 =?utf-8?B?emtpK0FGdEhBSHpVL0pUMVRxbE5zNlpMaXo5RWpNMjF5R3FXcXFsbUlrM1RD?=
 =?utf-8?B?V2FWa0JnR1pnajNDUk5Ka1AwTWNaaVp1REt6RXpKVHR0OW9tdGNEVmRDZEtJ?=
 =?utf-8?B?b2tMdGMwL2dYLzl1cUZGcmFYbDJjTzFFSUpwZTZXdGZJMTRzMis3UWtPQVJp?=
 =?utf-8?B?ODJORlNra0xLUkZMbmNHVGovVE1xSy9JMzQ4K2VXclNnQWpwaG93dGhQdGEr?=
 =?utf-8?B?aUorZ0ZoeENRWlJaLzdrRTdWRDZicHNGRFJ6RWxEeFJHWTdVWFNLcFVwcEhp?=
 =?utf-8?B?eWN5K1JHZjZhZGZiellIMGwxOWw2Q3hLcGpoRFdBN1hPZlVUQ0FZb2p0VDRs?=
 =?utf-8?Q?yGD8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3817a9-5dca-4932-7696-08d9aa49461f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 04:09:53.9105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sdyL6ypnFbTj4/KL01kbVqNParzBoyKPYnnjoBGpSH3szXSwyBnO/x64nrdAESH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
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



On 11/18/2021 9:29 AM, Yang, Stanley wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----邮件原件-----
>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>> 发送时间: Wednesday, November 17, 2021 7:15 PM
>> 收件人: Yang, Stanley <Stanley.Yang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Clements, John <John.Clements@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> 主题: Re: [PATCH Review 4/4] query umc error info from ecc_table
>>
>>
>>
>> On 11/17/2021 3:41 PM, Stanley.Yang wrote:
>>> if smu support ECCTABLE, driver can message smu to get ecc_table then
>>> query umc error info from ECCTABLE apply pmfw version check to ensure
>>> backward compatibility
>>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 42 ++++++++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  7 ++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 71 +++++++++++++--
>> ----
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 ++
>>>    6 files changed, 107 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 90f0db3b4f65..6b0f2ba1e420 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -888,6 +888,38 @@ void amdgpu_ras_mca_query_error_status(struct
>> amdgpu_device *adev,
>>>    	}
>>>    }
>>>
>>> +static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev,
>>> +struct ras_err_data *err_data) {
>>> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>> +
>>> +	/*
>>> +	 * choosing right query method according to
>>> +	 * whether smu support query error information
>>> +	 */
>>> +	if ((ras->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
>>> +			!smu_get_ecc_info(&adev->smu, (void *)&(ras-
>>> umc_ecc))) {
>>> +
>>
>> This version check should be in aldebaran_ppt implementation. In general
>> the callback will check the FW version that supports ECC table for the
>> corresponding ASIC. It may return ENOTSUPP or similar if the FW version
>> doesn't support ECC table and that may be checked here. Keeping
>> smu_version in ras context is not needed.
> [Yang, Stanley] I think just check Aldebaran_ppt callback function is not enough here, considering this scenario using amdgpu driver with get_ecc_info callback function but the pmfw is an older one without ecctable feature. PMFW support ecctable since 68.42.0 for Aldebaran.

What I meant is the FW version check code should be part of 
aldebaran_get_ecc_info() function, and it shouldn't be here. That 
function checks if the FW supports ecc_info for aldebaran, if ont 
returns ENOTSUPP.

Similarly for a newer ASIC, the corresponding ppt_func checks 
compatibility. That is one of the purposes of ASIC specific callbacks.

Thanks,
Lijo
> 
>>
>>> +		if (adev->umc.ras_funcs &&
>>> +			adev->umc.ras_funcs-
>>> message_smu_query_ras_error_count)
>>> +			adev->umc.ras_funcs-
>>> message_smu_query_ras_error_count(adev,
>>> +err_data);
>>> +
>>> +		if (adev->umc.ras_funcs &&
>>> +			adev->umc.ras_funcs-
>>> message_smu_query_ras_error_address)
>>> +			adev->umc.ras_funcs-
>>> message_smu_query_ras_error_address(adev, err_data);
>>> +	} else {
>>> +		if (adev->umc.ras_funcs &&
>>> +			adev->umc.ras_funcs->query_ras_error_count)
>>> +			adev->umc.ras_funcs->query_ras_error_count(adev,
>> err_data);
>>> +
>>> +		/* umc query_ras_error_address is also responsible for
>> clearing
>>> +		 * error status
>>> +		 */
>>> +		if (adev->umc.ras_funcs &&
>>> +		    adev->umc.ras_funcs->query_ras_error_address)
>>> +			adev->umc.ras_funcs-
>>> query_ras_error_address(adev, err_data);
>>> +	}
>>> +}
>>> +
>>>    /* query/inject/cure begin */
>>>    int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>>>    				  struct ras_query_if *info)
>>> @@ -901,15 +933,7 @@ int amdgpu_ras_query_error_status(struct
>>> amdgpu_device *adev,
>>>
>>>    	switch (info->head.block) {
>>>    	case AMDGPU_RAS_BLOCK__UMC:
>>> -		if (adev->umc.ras_funcs &&
>>> -		    adev->umc.ras_funcs->query_ras_error_count)
>>> -			adev->umc.ras_funcs->query_ras_error_count(adev,
>> &err_data);
>>> -		/* umc query_ras_error_address is also responsible for
>> clearing
>>> -		 * error status
>>> -		 */
>>> -		if (adev->umc.ras_funcs &&
>>> -		    adev->umc.ras_funcs->query_ras_error_address)
>>> -			adev->umc.ras_funcs-
>>> query_ras_error_address(adev, &err_data);
>>> +		amdgpu_ras_get_ecc_info(adev, &err_data);
>>>    		break;
>>>    	case AMDGPU_RAS_BLOCK__SDMA:
>>>    		if (adev->sdma.funcs->query_ras_error_count) { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> index bcbf3264d92f..3f0de0cc8403 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> @@ -322,6 +322,12 @@ struct ras_common_if {
>>>
>>>    #define MAX_UMC_CHANNEL_NUM 32
>>>
>>> +/*
>>> + * SMU support ECCTABLE since version 68.42.0,
>>> + * use this to decide query umc error info method  */ #define
>>> +SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
>>> +
>>>    struct ecc_info_per_ch {
>>>    	uint16_t ce_count_lo_chip;
>>>    	uint16_t ce_count_hi_chip;
>>> @@ -375,6 +381,7 @@ struct amdgpu_ras {
>>>
>>>    	/* record umc error info queried from smu */
>>>    	struct umc_ecc_info umc_ecc;
>>> +	uint32_t smu_version;
>>>    };
>>>
>>>    struct ras_fs_data {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> index 0c7c56a91b25..2c3e97c9410b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> @@ -97,28 +97,57 @@ int amdgpu_umc_process_ras_data_cb(struct
>> amdgpu_device *adev,
>>>    	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>
>>>    	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
>>> -	if (adev->umc.ras_funcs &&
>>> -	    adev->umc.ras_funcs->query_ras_error_count)
>>> -	    adev->umc.ras_funcs->query_ras_error_count(adev,
>> ras_error_status);
>>>
>>> -	if (adev->umc.ras_funcs &&
>>> -	    adev->umc.ras_funcs->query_ras_error_address &&
>>> -	    adev->umc.max_ras_err_cnt_per_query) {
>>> -		err_data->err_addr =
>>> -			kcalloc(adev->umc.max_ras_err_cnt_per_query,
>>> -				sizeof(struct eeprom_table_record),
>> GFP_KERNEL);
>>> -
>>> -		/* still call query_ras_error_address to clear error status
>>> -		 * even NOMEM error is encountered
>>> -		 */
>>> -		if(!err_data->err_addr)
>>> -			dev_warn(adev->dev, "Failed to alloc memory for "
>>> -					"umc error address record!\n");
>>> -
>>> -		/* umc query_ras_error_address is also responsible for
>> clearing
>>> -		 * error status
>>> -		 */
>>> -		adev->umc.ras_funcs->query_ras_error_address(adev,
>> ras_error_status);
>>> +	if ((con->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
>>> +			!smu_get_ecc_info(&adev->smu, (void *)&(con-
>>> umc_ecc))) {
>>> +
>> Same comment as above.
>>
>>> +		if (adev->umc.ras_funcs &&
>>> +		    adev->umc.ras_funcs-
>>> message_smu_query_ras_error_count)
>>> +		    adev->umc.ras_funcs-
>>> message_smu_query_ras_error_count(adev,
>>> +ras_error_status);
>>> +
>>> +		if (adev->umc.ras_funcs &&
>>> +		    adev->umc.ras_funcs-
>>> message_smu_query_ras_error_address &&
>>> +		    adev->umc.max_ras_err_cnt_per_query) {
>>> +			err_data->err_addr =
>>> +				kcalloc(adev-
>>> umc.max_ras_err_cnt_per_query,
>>> +					sizeof(struct eeprom_table_record),
>> GFP_KERNEL);
>>> +
>>> +			/* still call query_ras_error_address to clear error
>> status
>>> +			 * even NOMEM error is encountered
>>> +			 */
>>> +			if(!err_data->err_addr)
>>> +				dev_warn(adev->dev, "Failed to alloc
>> memory for "
>>> +						"umc error address
>> record!\n");
>>> +
>>> +			/* umc query_ras_error_address is also responsible
>> for clearing
>>> +			 * error status
>>> +			 */
>>> +			adev->umc.ras_funcs-
>>> message_smu_query_ras_error_address(adev, ras_error_status);
>>> +		}
>>> +	} else {
>>> +		if (adev->umc.ras_funcs &&
>>> +		    adev->umc.ras_funcs->query_ras_error_count)
>>> +		    adev->umc.ras_funcs->query_ras_error_count(adev,
>>> +ras_error_status);
>>> +
>>> +		if (adev->umc.ras_funcs &&
>>> +		    adev->umc.ras_funcs->query_ras_error_address &&
>>> +		    adev->umc.max_ras_err_cnt_per_query) {
>>> +			err_data->err_addr =
>>> +				kcalloc(adev-
>>> umc.max_ras_err_cnt_per_query,
>>> +					sizeof(struct eeprom_table_record),
>> GFP_KERNEL);
>>> +
>>> +			/* still call query_ras_error_address to clear error
>> status
>>> +			 * even NOMEM error is encountered
>>> +			 */
>>> +			if(!err_data->err_addr)
>>> +				dev_warn(adev->dev, "Failed to alloc
>> memory for "
>>> +						"umc error address
>> record!\n");
>>> +
>>> +			/* umc query_ras_error_address is also responsible
>> for clearing
>>> +			 * error status
>>> +			 */
>>> +			adev->umc.ras_funcs-
>>> query_ras_error_address(adev, ras_error_status);
>>> +		}
>>>    	}
>>>
>>>    	/* only uncorrectable error needs gpu reset */ diff --git
>>> a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index ea65de0160c3..7a06021a58f0 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -1404,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu,
>>> bool enable);
>>>
>>>    int smu_wait_for_event(struct amdgpu_device *adev, enum
>> smu_event_type event,
>>>    		       uint64_t event_arg);
>>> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>>>
>>>    #endif
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 01168b8955bf..6340c079f35e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -3072,6 +3072,18 @@ int smu_set_light_sbr(struct smu_context *smu,
>> bool enable)
>>>    	return ret;
>>>    }
>>>
>>> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc) {
>>> +	int ret = -1;
>>> +
>>> +	if (smu->ppt_funcs &&
>>> +		smu->ppt_funcs->get_ecc_info)
>>> +		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
>>> +
>>
>> Shouldn't return -1 if ppt func is not present. If ppt func is not present, that
>> means this method is not supported for the SOC; return ENOTSUPP.
> [Yang, Stanley] thanks, return -ENOTSUPP is more reasonable.
>>
>>> +	return ret;
>>> +
>>> +}
>>> +
>>
>> Probably the above function should be clubbed with patch 3 - smu support
>> for getting ras ecc info.
>>
>>>    static int smu_get_prv_buffer_details(void *handle, void **addr, size_t
>> *size)
>>>    {
>>>    	struct smu_context *smu = handle;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 55421ea622fb..55ef10ca684a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -200,11 +200,15 @@ int smu_v13_0_check_fw_version(struct
>> smu_context *smu)
>>>    	uint16_t smu_major;
>>>    	uint8_t smu_minor, smu_debug;
>>>    	int ret = 0;
>>> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(smu->adev);
>>>
>>>    	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>>>    	if (ret)
>>>    		return ret;
>>>
>>> +	/* record smu interface version, help umc query error method */
>>> +	ras->smu_version = smu_version;
>>> +
>>
>> This is not needed. ASIC specific functions can check the FW version for ECC
>> table support.
>>
>> Thanks,
>> Lijo
>>
>>>    	smu_major = (smu_version >> 16) & 0xffff;
>>>    	smu_minor = (smu_version >> 8) & 0xff;
>>>    	smu_debug = (smu_version >> 0) & 0xff;
>>>
