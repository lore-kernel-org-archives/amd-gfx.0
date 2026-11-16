Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6B606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nryz6nhC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D931D10E553;
	Mon, 16 Nov 2026 15:25:35 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F04310E553
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4pjggy2vblyTOR6e4MrMQpsS1QK4EU66EHRJ0s/raG5iUMUy3WV0WPCgMq80qklXwuA0qZaL2TsgHKZ8QdJZ/wLEqT7KxZV0z2CM1qhwBcPy7DW75PPJf7OvsTRmsggetNnlJWTXr2RPVU2h+UoSYUYTc9P13wMWq3bfJ9X1CsaTLujKXZRUmWlxANpxlBY6ppR3RrRCUwPYqYAgE1qS3H9vGNehzjiB2Uvj0kHhJyrFkIqG0WWiWTh+4zJ6AfQdA1U8Pk+uEY7aanALH5l+YNDI0HvEEjaax3rU7C4Msq+G+v3OhTGVcXID2IKhQakoXDapSwUlC5cIKrA4pRGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+0Hx+zaXONrGjwkFwNd1uzaWXWf47piFIrgm0egZg4=;
 b=RUHTIGrF1aVCsSgBe5RyiL6umSYgWE7SFzO2DpZE3PNz3InrsfGAO+eD+CKG/uCHv7m/BtP8AEms2r65umMDIm+4VwcVB8gEEL3T+W1Qx+0rOZMng1ZV7p6qxEx3Ez86jV+1jbFXF6WqVGtiK8lSioiNLDzDP3YdrW0vA3Vu4/rYTaXoz1tvXbCvKuYvX/B9+1A2nsUz2CblGQvv/2kQSRMi95pn6F6bCN49+I0e3t5NpBsxL30VBPipRO8FnRKqcr5gu1e6I/zw3YmNArvIWPWo2sXoQncjLbebqAAPDRSvdyck6ihmYNK55ErUcUQSg/i9w2J8Lzxmw9rkyv92Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+0Hx+zaXONrGjwkFwNd1uzaWXWf47piFIrgm0egZg4=;
 b=nryz6nhCkq4UMA1PKOcLH3RbQOTEClnLkSEbl8cjoJOChxvYzpRLGwL5IvFahotSguDphBJSeFDFXMCWA2ge9wkhQAYbA5DXa8ivIObT/x/lKm1Sn6Z6trw8RpVH+syRIcV7fOfKSvAN9/OEyYjGik4Di/jJO3gftmHdSO47/uk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:24:23 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:24:22 +0000
Content-Type: multipart/mixed; boundary="------------FoDWkIUyBkwH8R7mubzhzYem"
Message-ID: <385b0781-f3f1-4819-a027-d6e3f5532783@amd.com>
Date: Mon, 16 Nov 2026 09:24:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Perez, Randy" <Randy.Perez@amd.com>, "Chiu, Michael"
 <Michael.Chiu@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
 <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
X-ClientProxiedBy: DS1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::8)
 To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f92e550-5abe-495d-6897-08df43f5b0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|6049299003|366016|18002099003|22082099003|6133799003|261009223027099003|4053099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: upYO0lLHP4nPb1kSlqvC9YmIMR2EKvYztVBfHsm8sM2QY/T8Wdh2Q9OEOM/igtylmKzTN4uuOTAYGGVKEXxk54Zloqo7HDcgzEE6oEWvoR5afTwX1c4PJPBS5MuSlQbG9mWdkzel18OgJlpWQTIKFPzYUvHOZX03AHMfcQkt2ZpnYW1O5+U5QxXfFMlddEWkWNKGfCxXPocY23pzAs0YBwDVG6EsgE+vztic13PQAaLQS3fJQ/m4mend3g7TP+93o3QSi6qOjhonfxT+bKzMwzUl/4q5p4Zv7SEb2jVk5klPhZLgzzpasIvZuu8JekkSKmKA5ONAQh/C53VfV9gl4K6eMjJ8CYSYEgw1n0UuMbkgEe5LQJLAivPI+gt8F/O8bwAqK3PTxQ59eHMTBT0XfXVTX56SS8S3zV896wzD3t9v649AT2EfgmQBLj9CHYsn8eJ6EoVE29ARv/3+0VskoFrAtmi1Ad2zXFtgY0JcwFAHS7EfPXb8i5at17U0aG/5MQMNEVtmuTdWoYkmk7Lx/XlPxDrdE3PhuS2bhhqYlnn0m+JyAQJuoqQB591CsEOS21QIdXavJH8+yXygLztBq4VNmoW6ARG5raCQYVzu9pz3XT2OjbUGYGeXI39Jsj5XD4MDK4AopYbDRT5auAOAHqISgbeMQDMmD02rQfkAAv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(6049299003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4053099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNVczBXR0s3WG5RVE1HL2oxUmNaS2t0M3R5ZGozUmg2ZisvcXRLelhpWmxP?=
 =?utf-8?B?NjI0aEROOE9rRUxidHFEZXltazhnNThHZ1hpOGRkWktaOEd3TEVJUU0xRmFN?=
 =?utf-8?B?UzlhenQvRlV2NzlXbnRFSnZZUnMwWjhZTjlyanJCUUlwdFVOcHdFY1RnVFJJ?=
 =?utf-8?B?Z1FqSHpNbTB2d2RJR3pDWnVxY3ovN1Y4TnZ6V0ZJTU00U21DK1poc0QybzhL?=
 =?utf-8?B?Ri85OGcvOEdBNlZjOHdiZ09zbWhyRHNIelZFbi9CU05mUUVoMG5tdVh6N051?=
 =?utf-8?B?RTR3S28reENYTkJjVUhpR3U0SkRzbnJVUUo0cjBrcW9GdUNUNHhoVWljQmFh?=
 =?utf-8?B?bzhDaW55M1ZXejJhd0tNT0p0Ykd3VWY1cVVKVkF1Qms3NVF3MzRJYi9xVFdP?=
 =?utf-8?B?RTNxZTlrZEhsL3BUM1gycEIvaWo2bFltMkg3azU1cTZUNm5tb2UrLzgyQmNK?=
 =?utf-8?B?VHQ0cXN3S011QU16cDFvZ1JRSUUyK0UyankxMVkyVldmL0hLN0dRZFc0YVhx?=
 =?utf-8?B?b2FUSUdneHhyM3RwZDdvNUJGT3VZODUxOFZRUXVlY1lGWW9wVmJxQzJxRU5z?=
 =?utf-8?B?NkZ0UXJDMTFvc0s3b3NuYStJVSt5a1B0akkzKzdHbTJEQ2lkTFRMQlZsblFl?=
 =?utf-8?B?bDFCYlhaV1lWS0dNTG5FNUJ3TTNzc3FVWC8rZ2ZEME8xK3NGRC9wVmVwb2RR?=
 =?utf-8?B?WFhVaDJENjVnVE44OUtuM2xucUM0RkZhd1Jhd0tqeGNvTXYvVXZhdUdHRFVW?=
 =?utf-8?B?YVVHY1ZMTUUxRWU3YjYyTVB2R3ZkREpiakxlMng2MS9tZUMzVUNzTDJPWC95?=
 =?utf-8?B?ODFiM2lMTCs2NVZkUytNTTdUR1Nub2FTTDJ0U0tpTk1INU9xNjdpaVBsOWJI?=
 =?utf-8?B?TTUwWWhxdlZwWlpTYWZaNWx5U1hBVXo1U2RoaUxEQmZKK3FEMXo1VjgvZi9R?=
 =?utf-8?B?ZGlKSWN5TDdkUkJkaWExaHVlRlFxSXovbzZjSTd1RW12R0VaNkFCNjQrUkZG?=
 =?utf-8?B?UWxUVjBwNnY5YVVJNmRKb1A1ZmRLbWtYdWxLVWJ5YWRrTXF0dWkzRnAvUGlj?=
 =?utf-8?B?ajRrdTJ3SEphaDcwQ1VxaG5CRjZHbnJGY3lFRkY1My9qYjRTakRxRDNGQ3o2?=
 =?utf-8?B?dVBWZ2ZyUEVPVStCd1NtbkVVa0NhMHQ0Q0x5ZDMrWm5XakxMU3o0KzR6Vlcw?=
 =?utf-8?B?aVF5TjgvclZUdUwwdlZSQnhwSXk2K1prZFlmb2VldS8yeWVBUHJORDJYQlhP?=
 =?utf-8?B?NTlXUXZhdytLcG1FVG83MjI0TUdCZWxhcnNtZFJ3REhValVCdmcvMGRZT0k3?=
 =?utf-8?B?MW9GVU5NU0J0U3hnQzI5V2laSnpWV2N5L0xnbnQxOTFQUEMzbi8yNjY4ckZh?=
 =?utf-8?B?ZmtGUk43VGZRN3VXazlraTUrUEp4U0o4czdlWnpaUnRYa3pyZSs5ckdFVDR1?=
 =?utf-8?B?SGxtNGx4MHo2c3FiWldqUXpVVy9WYUJDOGxUMURhajlQbVI2TlBOeFZLdVB4?=
 =?utf-8?B?N3MxajVuN01KeDRISmlFVTcxTWluN0FwVER0QkFRTjdXeVZ4VldwRXN6eU5p?=
 =?utf-8?B?NmNaeFE0a0NpbE5DN0ZrbWZmcm5BVTBYcjdpYit1WmFYVXFFVlZmRHNLclQr?=
 =?utf-8?B?MC9PeFFaZmpQcWYxZS9jS1BYSm5yLytpdVZvOGhITlRFN2s0blRUaFJid2p4?=
 =?utf-8?B?eVVraloybmd2cWZaWkZlanIyRDd6SmpsQ00ra29qMDR0bFlFcHpZR2pyWE9a?=
 =?utf-8?B?RE80cEJNdjg5Y0F3UjM2OE5BTVVmSS80aER5ZkNxK2ZuWnJVVmdWOGY0YXlq?=
 =?utf-8?B?QUw3c1RTWWtYYUU1alJLK3Y5SE50REliczRrc2NRUG9wdnVQSVl0M3dyQ1Q1?=
 =?utf-8?B?TlZIdVU3Y0pHQjQ1YWo3TmNBL2g4MGZjTXhGOWlLVk9aOGkrNnZybWh2T3ow?=
 =?utf-8?B?b3p1OGJKZ1Z1ekl2SXZIZno0M2NkYlF4Ync3L094dHhtMjdTZ0pOVWIwOGVh?=
 =?utf-8?B?a1dCQWNnYkFjVjlraFd4UmREV01YZTBMOUhZeVdPeENNcFdoUkVTTGROUkRy?=
 =?utf-8?B?K0VkU212L3lwQVpxbTBudmlGa0dpVTRwRVpzdTMwaUIvYlB1aDN0RVNIcklD?=
 =?utf-8?B?M1VoWWZYNFp5WS8vZzhOR0Urayt1TTN1U2gzOHdvbDJySkR3SG5vV0VCS2Qv?=
 =?utf-8?B?ck5EdnQ1UlVseFNBZ29FR2dGRVpxMjkxM3ZaYmJJOU9lczZIUlZ0WTRDZkNt?=
 =?utf-8?B?ajREbzBYTFNmTUZRcmVwWVNVUXJQaDV5MWNydjREQ3Vtak5HT3RZZXJJbHky?=
 =?utf-8?B?TDdLT3ppQjZ1NDZNMmlxQnNvMkRqNWhSeDV5dWxhMnhxck9IWEFTQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f92e550-5abe-495d-6897-08df43f5b0e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:24:22.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axYSh5Ti4gIbX57zi1rcRgJilwJ+v2F8aIzHySIXgQmVM8rrri73TERr+Ov5m6CZw2ZrYT5QQlo7F8dDf8OBcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------FoDWkIUyBkwH8R7mubzhzYem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/16/26 09:04, Christian König wrote:
> Hi Tharshan,
> 
> the idea looks good in general, but could be simplified a bit by waiting for the VM to be idle.
> 
> Question is why don't we already have that? Or do we already have that somewhere else? I'm pretty sure that waiting for all submissions before S3 should already been implemented somewhere.
> 
> Adding Mario to answer that question, he has been working on suspend/resume quite a lot recently.

I thought we had something like this, but looking through the code base 
it seems not (or I missed it).

I think it's the wrong kind of patch though.  I believe we should use 
some of the existing flush functions and do it at the same time that we 
evict resources.  Something like this (attached).

Can you see if this also helps?

> 
> Adding Vitaly to double check if we have already a test case for that.
> 
> Thanks,
> Christian.
> 
> On 11/13/26 17:44, Thothiralingam, Logatharshan wrote:
>> AMD General
>>
>>
>> Hi,
>>
>>   
>>
>> Please help me review the attached patch.
>>
>>   
>>
>> A gfx hang that occurs 2 out of 400 times when performing S3 cycles. The issue is seen with the kernel version 6.18.8 and on AMD hardware; Picasso gfx9 APU.
>>
>>   
>>
>> When going to S3 suspend, the driver checks whether GPU has completed its tasks, but it doesn’t wait for jobs that are submitted to the scheduler. As a result, queued up jobs slip into the ring and are lost when WPTR is set to 0. On wake up, we hit a timeout followed by a hang.
>>
>>    
>>
>> The fix is to wait for all scheduled task to finish before going to S3. I tested the patch and the issue is not seen again.
>>
>>   
>>
>>   
>>
>> Thanks,
>>
>> Tharshan
>>
> 

--------------FoDWkIUyBkwH8R7mubzhzYem
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-drain-queued-user-submissions-before-susp.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-drain-queued-user-submissions-before-susp.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhZWNiYTU5NDk4MzJhZjUwZTYyYTc3ODI1NzM0NjcwYWNkYWIwYmY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogTW9uLCAxNiBOb3YgMjAyNiAwOToxODowNiAtMDYwMApTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRncHU6IGRyYWluIHF1ZXVlZCB1c2VyIHN1Ym1pc3Npb25zIGJlZm9yZSBz
dXNwZW5kCgpBdCBzdXNwZW5kLCBhbWRncHVfZmVuY2VfZHJpdmVyX2h3X2ZpbmkoKSBvbmx5IHdh
aXRzIGZvciB0aGUgbGFzdCBmZW5jZQplbWl0dGVkIHRvIGVhY2ggcmluZy4gSm9icyBzdGlsbCBx
dWV1ZWQgaW4gYSBzY2hlZHVsZXIgZW50aXR5IGhhdmUgbm90CnJlYWNoZWQgcnVuX2pvYigpIHll
dCBhbmQgc28gaGF2ZSBubyBoYXJkd2FyZSBmZW5jZS4gVXNlcnNwYWNlIGlzIGZyb3plbgphdCB0
aGlzIHBvaW50LCBidXQgc3VjaCBqb2JzIGNhbiBiZWNvbWUgcnVubmFibGUgbGF0ZXIsIGZvciBl
eGFtcGxlIG9uY2UKYSBkZXBlbmRlbmN5IHNpZ25hbHMsIGFuZCB0aGUgc2NoZWR1bGVyIHRoZW4g
cHVzaGVzIHRoZW0gaW50byB0aGUgcmluZwphZnRlciB0aGUgaGFyZHdhcmUgd2FpdCBoYXMgZmlu
aXNoZWQgYW5kIGJlZm9yZSB0aGUgSVAgYmxvY2tzIGFyZSB0b3JuCmRvd24uIE9uIHJlc3VtZSB0
aGUgcmluZyB3cml0ZSBwb2ludGVyIGlzIHJlc2V0LCB0aG9zZSBqb2JzIG5ldmVyCnNpZ25hbCBh
bmQgdGhlIEdGWCByaW5nIHRpbWVzIG91dCBhbmQgaGFuZ3MuCgpUaGlzIHdhcyBvYnNlcnZlZCBh
cyBhIHJhcmUgKGFib3V0IDIgaW4gNDAwIGN5Y2xlcykgR0ZYIGhhbmcgb24gUzMgcmVzdW1lCm9u
IFBpY2Fzc28uCgpGbHVzaCB0aGUgY29udGV4dCBlbnRpdGllcyBhbmQgdGhlIFZNIHVwZGF0ZSBl
bnRpdGllcyBvZiBldmVyeSBvcGVuIGZpbGUKYmVmb3JlIGV2aWN0aW5nIHJlc291cmNlcywgbWly
cm9yaW5nIHdoYXQgYW1kZ3B1X2ZsdXNoKCkgZG9lcyBvbiBmaWxlCmNsb3NlLiBUaGUgd2FpdCBp
cyBib3VuZGVkOyBmYWlsaW5nIHRvIGRyYWluIGluIHRpbWUgb25seSBsb2dzIGEgd2FybmluZwph
bmQgc3VzcGVuZCBjb250aW51ZXMsIGxlYXZpbmcgdGhlIGV4aXN0aW5nIGhhcmR3YXJlIGZlbmNl
IHdhaXQgdG8gZGVhbAp3aXRoIHRoZSByZXN0LgoKUmVwb3J0ZWQtYnk6IExvZ2F0aGFyc2hhbiBU
aG90aGlyYWxpbmdhbTxMb2dhdGhhcnNoYW4uVGhvdGhpcmFsaW5nYW1AYW1kLmNvbT4KQ2xvc2Vz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbWQtZ2Z4L1NBMVNQUk1CMDA3MzI5MkMxMTNDNkI5
OEQ5MjgyMDkyRjg3RjJAU0ExU1BSTUIwMDczLm5hbXByZDEyLnByb2Qub3V0bG9vay5jb20vClNp
Z25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDM0ICsr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDE5YTU2NjE4
N2RmYjUuLmUzMzZjMTk2NDBmYWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKQEAgLTQ1MzgsNiArNDUzOCwzOCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfY29t
cGxldGUoc3RydWN0IGRybV9kZXZpY2UgKmRldikKIAl9CiB9CiAKKy8qKgorICogYW1kZ3B1X2Rl
dmljZV9mbHVzaF91c2VyX3N1Ym1pc3Npb25zIC0gZHJhaW4gcXVldWVkIHVzZXIgc3VibWlzc2lv
bnMKKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVjdAorICoKKyAqIFdhaXQgZm9yIHRoZSBz
Y2hlZHVsZXIgZW50aXRpZXMgb2YgYWxsIG9wZW4gZmlsZXMgKGNvbnRleHQgZW50aXRpZXMgYW5k
CisgKiBWTSB1cGRhdGUgZW50aXRpZXMpIHRvIHJ1biBvdXQgb2YgcXVldWVkIGpvYnMsIHNvIHRo
YXQgbm90aGluZyBjYW4gc2xpcAorICogaW50byB0aGUgcmluZ3MgYWZ0ZXIgdGhlIGhhcmR3YXJl
IGZlbmNlcyB3ZXJlIHdhaXRlZCBvbiBhdCBzdXNwZW5kIHRpbWUuCisgKiBGYWlsaW5nIHRvIGRy
YWluIGluIHRpbWUgaXMgbm90IGZhdGFsLCB0aGUgaGFyZHdhcmUgZmVuY2Ugd2FpdCBhbmQgdGhl
CisgKiBJUCBzdXNwZW5kIGhhbmRsZSB3aGF0ZXZlciBpcyBsZWZ0LgorICovCitzdGF0aWMgdm9p
ZCBhbWRncHVfZGV2aWNlX2ZsdXNoX3VzZXJfc3VibWlzc2lvbnMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCit7CisJc3RydWN0IGRybV9kZXZpY2UgKmRkZXYgPSBhZGV2X3RvX2RybShhZGV2
KTsKKwlsb25nIHRpbWVvdXQgPSBNQVhfV0FJVF9TQ0hFRF9FTlRJVFlfUV9FTVBUWTsKKwlzdHJ1
Y3QgZHJtX2ZpbGUgKmZpbGU7CisKKwlndWFyZChtdXRleCkoJmRkZXYtPmZpbGVsaXN0X211dGV4
KTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGZpbGUsICZkZGV2LT5maWxlbGlzdCwgbGhlYWQpIHsK
KwkJc3RydWN0IGFtZGdwdV9mcHJpdiAqZnByaXYgPSBmaWxlLT5kcml2ZXJfcHJpdjsKKworCQl0
aW1lb3V0ID0gYW1kZ3B1X2N0eF9tZ3JfZW50aXR5X2ZsdXNoKCZmcHJpdi0+Y3R4X21nciwgdGlt
ZW91dCk7CisJCWlmICh0aW1lb3V0ID4gMCkKKwkJCXRpbWVvdXQgPSBhbWRncHVfdm1fd2FpdF9p
ZGxlKCZmcHJpdi0+dm0sIHRpbWVvdXQpOworCQlpZiAodGltZW91dCA8PSAwKSB7CisJCQlkZXZf
d2FybihhZGV2LT5kZXYsCisJCQkJICJmYWlsZWQgdG8gZHJhaW4gdXNlciBzdWJtaXNzaW9ucyAo
JWxkKVxuIiwKKwkJCQkgdGltZW91dCk7CisJCQlicmVhazsKKwkJfQorCX0KK30KKwogLyoqCiAg
KiBhbWRncHVfZGV2aWNlX3N1c3BlbmQgLSBpbml0aWF0ZSBkZXZpY2Ugc3VzcGVuZAogICoKQEAg
LTQ1ODcsNiArNDYxOSw4IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgYm9vbCBub3RpZnlfY2xpZW50cykKIAlpZiAocikKIAkJZ290byB1bndpbmRf
aXBfcGhhc2UxOwogCisJYW1kZ3B1X2RldmljZV9mbHVzaF91c2VyX3N1Ym1pc3Npb25zKGFkZXYp
OworCiAJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2VzKGFkZXYpOwogCWlmIChyKQog
CQlnb3RvIHVud2luZF91c2VycTsKLS0gCjIuNDMuMAoK

--------------FoDWkIUyBkwH8R7mubzhzYem--
