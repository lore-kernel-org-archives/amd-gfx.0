Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5FD606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bt9g4d1F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF49B112505;
	Thu, 22 Oct 2026 11:12:58 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B22112505
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ0UQuxQDWQAz0HVrWaYi933ls7kVIrnEbVSWiiOWYnBeWO4OsZR1LLLLuDK3DjZUPHnEBILeo+mmHZKkcVTKe7MyGMkL5B/q6LDKb82HlKJaX8P70KC/hog/rERpsdMVdehABqNqkQSCUyz4VT+uPt3lROhEmodZSYe9lsZqOxpzsuiz1bpQ3RK2RRKhUSqpxOvH0aV8uuJgluYwc/nA8NC0HGoVrh/2gY1oTkbUTWdrIdk7DJUycwHdwrYJzhTpn3Ac4Yybjk2+gVB+0WHfZuGbfUmW0OEBEyDqTdOUUfTfx+SDcsK40utYA3/uGMEua1OXsmuYThb0+lC6zqI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BagX2aKD6YztunbnQlQblzBnGqfSqBqZT3f26jaUs7I=;
 b=gVA/xBf9YH/918HRxX/S/DpQkoTC5XYx66Zz3qc+bPckzFG1iSWNHt+lWH4eA3hUC236BxjYAVNGcjXTxva1bqzVemG8M1+pl/bSD/nvVkMI7GPemDwQ53nE1f2J7Z4rVMdgt20ib544kTfgNYCfRoEY/GHB8UYKCHCtaV8HRPddOkK4jYxOkCwYCzDtDH/5ooY6Z2f/fm5tpILxcarBepodAcBQCsrbwj4Ks85HAZdLPj3xSoYqJHbej6tSId4GsyY/cZ7G5bUI6PsXfJHAEN5JhQ+AxGFiRiQr4lj4AHZuKfDbf7NSq83OC3gTYCfaIc9lUoPFzI8L7P2/DmRHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BagX2aKD6YztunbnQlQblzBnGqfSqBqZT3f26jaUs7I=;
 b=bt9g4d1F+vzt86uiG+S1FnGAyEMZyDTi1w6sHyZZYx9VRR9Gw2xQ0sVUe0mJdhYzpJhGayAbqzGBlgp/mKxtFJS2wE/Q0UL32XYr3Ri7EDd5emZYmRhZ5gcLUk74u2o8XneA7qT+N7AhuZp9Dqj/PYNYPOBIw9FVeY9p9IX4XcI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::995) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 11:12:48 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0496.019; Thu, 22 Oct 2026
 11:12:48 +0000
Content-Type: multipart/alternative;
 boundary="------------Y8qI0IrVe0eoV2OpoNpEDctQ"
Message-ID: <16850d5f-2e2c-4f6d-8ad3-83d3fde216f7@amd.com>
Date: Thu, 22 Oct 2026 19:12:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Benjamin.Welton@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
 <20261021111003.3371005-9-lingshan.zhu@amd.com>
 <CADnq5_OCp9_drutPypO9qCLWHgxzJDm=k1PZBSTW20SNxLJV8A@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <CADnq5_OCp9_drutPypO9qCLWHgxzJDm=k1PZBSTW20SNxLJV8A@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ddc822-51c8-4325-e09a-08df302d67ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|22082099003|261021121427099003|8096899003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: nuWBfFAQ19jRCFMcCJM5+9avx3quF78be1MQlJZHWnuX+EmTb96H78O+0yZxNomT6pqmTnuRPdkWWfRJJ1UJAcUXzf2p9ATy1MA6u0Sz2dYr6mmM+BNpAX23S5ojouWJYrc8aCr6siWCpMNVkd31rajDe9Xna8f15/Rr/rAQ5BgRByQ5gt7YuQ4HRa7dlnLAnQp5rT7fNtrsS+ydQEQKDRguIjZXHj83YILRol0fqYqWZQOVNj2bIy+ZXUZPPb7qZg5SW6kRyx3yqUS+VW5tJVlW3nQKE/1WmBxVrHqDiLmfNFwconQP2jJbefI62nRjkb18oCPq0uaHNlu+q3XY37R1GOncnhAylj+DaXGtQWAd+Yu82miHxuTHHP0sxWlHztOX4fH31yYI4SEUvYBHSrDvmYva0Rg4+zMoCPpO6dldGfbAZQZPqaJRZaS84MP7qS3T4lIeHzO1by4pWKOti2STwTTCHedEVBCpFGyTKoNMflkhNdfxvDENoED1Al6BRIpUjmnDf9K/PaqVDcMbu6/xY+6QeyPnedE1JY/JbN5oMyGBbxfiduLYyj3+0/15l4qfZw9tl6ZM9hibpn+3wXhI9NrZ5a3SQKgbIJH8h0DcODtSENK/czGPMD36GL6DrYldo50LGiLMShaufT3sib3RF4w0o2dmNVRWoK543W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(261021121427099003)(8096899003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdJQmFnRkk4WUV0L01ISnMwd3ZGUVZpbmxqVTlYdG1xVU85bG13c1Bjamoz?=
 =?utf-8?B?T3hlOSt5OCtBTVBKK1B6dFh1Qi8rOVVndWxrSUNSWjFaWlZ0VDltUHdlRDZS?=
 =?utf-8?B?eXZNRlFCT3ZFdFVIWDByc1Z6OTlldmNBWlQybnYzL0JVUnd3MFpacit3M1V6?=
 =?utf-8?B?a21KTVJWcTBxbW5ZRFJtYk5hMG5LdGFxaUR3VDJ1c2VIYkNCS0pBMmJGNVpy?=
 =?utf-8?B?RVBONEd5dktZOGw1djhBR3hlU1htbm1HSEt3M3h3ZW9HTGJ4MXVMRldwVlNG?=
 =?utf-8?B?TTh1SGxBVGh1RCtVYWc2cjZ5bE56c0gwbS9TcElnRTZML2FVU3BQMFVaSUdu?=
 =?utf-8?B?VVJtZ2xmSm5GNDFiY1VsWkd0cEJnVkdKNmhCRFZJcEtHN051b3llcm44aTY0?=
 =?utf-8?B?WEZlWDB2RDA1clRqL0VGaW8xRE11MkRjQ0FKMHU5T3hHa081eldHV2ZxQmNk?=
 =?utf-8?B?OFdBeWNPZFU5bVVjcmp5WVhSMWpTck5OR3dDekFaNHp5UkZBdGtmbUFlMUdv?=
 =?utf-8?B?eUNTa2s2R1cxRW9NQ2xLRXJHY0orTkJLZUhjSEozekhydUpaaVdxNFVvU0VY?=
 =?utf-8?B?OWdJbk1qeGRVYzgvdXZZbnFxdUpKZHN1L3c5ZGxuWHdnVU5mV1cyRi91dXg4?=
 =?utf-8?B?cDNRZmZCY3krVm1OcDZBZllCd3FQQVRxbkRGOCtIdzBBa3J6SnRnMXNEbFdl?=
 =?utf-8?B?bSs3U3BNWWxORE9oU0JBU0hESUUrTk5aUndLOHR3RmxpVVhTMm51dTlhaDRL?=
 =?utf-8?B?cVg4Rit3M3JFKzNhMG8vcFhjWEY2S3NzS3FBc1ZFZWhpWHZNbmVxQmR1S21z?=
 =?utf-8?B?NnlmQi9yb0hROFFtVGRxSDFXR0JnMnVsMEVPeXlWMlZKSHcvTWg5cmRrTGZt?=
 =?utf-8?B?aUNqemc3TU14THdwVWQ4TU1PcTMwSDhiQWlJL1VqOTArSnBvc1JGamROWEFz?=
 =?utf-8?B?amhRUUlHZzRMWTd2aTFMdm9WY2hBaVMxamkzNWlZdHE4TTNhdTZ2VE0xU3Qy?=
 =?utf-8?B?MkdaaWtzV0ZvZTFaRlZwV1poYnJ3TGJCa1dXYTZxTFFyYk9hZHBwV0lpQzlw?=
 =?utf-8?B?M0EyRUpWR2F6OUNIcVQ0Skl6M3ZjbUNqT1owbUgwc0xRcmxlWTFneTZnMWdo?=
 =?utf-8?B?OUdVMEwzUU5ScmJGS3dJL3FRRkRWM2UrTEZoTFJGWHdCcUdINm00M0Y2VUtT?=
 =?utf-8?B?TFZISWhoeUhMQ3BSTG9GbS9qTGJBeVdBdnpOSkZudU9yWHFGRi94NWdQUUVw?=
 =?utf-8?B?NXk5Q1RIMHpNT0QzNXRrWGVXTUF2dVBpK0duWW1WdUFUSi9hZDlYNEk4Ukty?=
 =?utf-8?B?SHdZZnk2TjV1TjRucUNOSzF0L1JtMFFmSUlZQStPRVFDVHZWcHlxYnE5cU5B?=
 =?utf-8?B?a1pSTnhkRzVNM1VVMkNOSE5Da3dZOUtadWNoa0JjL0tycE1GcXFXZWFIUWEz?=
 =?utf-8?B?QlNQM2NHVlFwSkw1WWN3OHR1THR1azEyWStjOTVBdVJJVmZNQUcrQ2tkUG9u?=
 =?utf-8?B?KzY5WDQ3RU1GejNCcGU3a29XUmp0N1NDV1FHMkNxMEJpVS9RbEhZNTdFMEZI?=
 =?utf-8?B?WXRqVUg5ZVBndXVydVRzVzFzaElrYWdvNVgwM0Q0RkNBZldiYlc3Rk11VnVI?=
 =?utf-8?B?VERQMDhZQjBJWWprRmIvYUlkaHZWTmxRR1ZhTDl2NFdLWmxWMDNOZzk2UE9X?=
 =?utf-8?B?eXpQelpXdWF6ZkNWY3hCclBIZjU5bndxd2laVEpFYlJGNEUvN3NPRk5SaVFD?=
 =?utf-8?B?SEUrSldVUXl5dlQ3REVyWUc5T0Z5Wm1QemlLK1hmdEIxT21IQWVsQ2lyb0pv?=
 =?utf-8?B?aGtSOHlMMzBra2tkQVNKZEFZaTNjdmd2Qm0veW1zUmFGOTI3ZkJweUpKWkd1?=
 =?utf-8?B?NU9ERlg0MTdRak5mSjNsdytkeXVqd2ltZEUrWWZCQXMxeCtPcEVmUnBFN1NG?=
 =?utf-8?B?UWlUWjRScFkwYkI2RWtyQnRYVU5nMVJaV2cyOVJ2MS9ESVRDL3dzQUkrdmlI?=
 =?utf-8?B?aGlTSUt4VWhtUk5kMDdVYmM0ZUNadi94bnhOek1HcjAzVGhxVEZyMG1CcTFq?=
 =?utf-8?B?dnVTTmpFa2lYaHhSMUhBbjU5WkRoZnZhV09BeER3QzMxdnl2VERwY2g4QXNz?=
 =?utf-8?B?WjZ5Umw4Y2tCakpZMW54TWdrbG4xVElXbXJsVEx6Mjc1VHRPdElNMzZablBB?=
 =?utf-8?B?ek5LNVVzVEJSS3FkQUV6UkY3QXMvVGh2dS9FSzhwc1pHUDlocHZjWHhlMEs5?=
 =?utf-8?B?WUNOTlBNczFUNlpuaUdoYlEydWV5MDRvb2ZOZWU4R3J4SmVpZVhGRjRGVGQw?=
 =?utf-8?Q?4y0bC9GT3fFDiXDtLn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ddc822-51c8-4325-e09a-08df302d67ce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:12:48.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZLQNV6vg6oeukIm35QplsCg3DTsgHycyivbLtaqt2mUF4VfWTJPtZoFsaFv/S6dpnwqsgvVOcemIuRhLLCWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Y8qI0IrVe0eoV2OpoNpEDctQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/21/2026 11:56 PM, Alex Deucher wrote:

> On Wed, Oct 21, 2026 at 7:16 AM Zhu Lingshan <lingshan.zhu@amd.com> wrote:
>> This commit implements a new callback set_mqd_perfcount
>> in struct amdgpu_mqd. This callback helps setting
>> mqd->compute_perfcount_enable from amdgpu_mqd_prop->perfcount_enable.
>>
>> This is a per-IP callback and it is NULL if an IP does not
>> support PMC.
>>
>> This commit also implements set_mqd_perfcount for GFX11.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++++++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 11 +++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 373c52b7022d..5ccaf805adb4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -480,12 +480,18 @@ struct amdgpu_mqd_prop {
>>         uint32_t ctx_save_area_size;
>>         uint32_t ctl_stack_size;
>>         bool modify;
>> +       /* PMC compute_perfcount_enable that programmed into this queue's MQD */
>> +       bool perfcount_enable;
>>  };
>>
>>  struct amdgpu_mqd {
>>         unsigned mqd_size;
>>         int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>>                         struct amdgpu_mqd_prop *p);
>> +       /* Per-IP callback to set compute_perfcount_enable,
>> +        * NULL when this IP's MQD has no perfcount_enable field.
>> +        */
>> +       void (*set_mqd_perfcount)(void *mqd, struct amdgpu_mqd_prop *p);
> Rather than adding a new callback, just route the update via init_mqd
> similar to what Jesse did for the modify queue interface.

Thanks Alex, I will work on this.

Thanks
Lingshan

>
> Alex
>
>>  };
>>
>>  /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 4b5faecf13b9..04e2d857e352 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>>
>>         mqd->header = 0xC0310800;
>>         mqd->compute_pipelinestat_enable = 0x00000001;
>> +       mqd->compute_perfcount_enable = prop->perfcount_enable;
>>         mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
>>         mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
>>         mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
>> @@ -4466,6 +4467,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>>         return 0;
>>  }
>>
>> +static void gfx_v11_0_compute_mqd_set_perfcount(void *m,
>> +                                               struct amdgpu_mqd_prop *prop)
>> +{
>> +       struct v11_compute_mqd *mqd = m;
>> +
>> +       mqd->compute_perfcount_enable = prop->perfcount_enable;
>> +}
>> +
>>  static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
>>  {
>>         struct amdgpu_device *adev = ring->adev;
>> @@ -7270,6 +7279,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
>>                 sizeof(struct v11_compute_mqd);
>>         adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
>>                 gfx_v11_0_compute_mqd_init;
>> +       adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
>> +               gfx_v11_0_compute_mqd_set_perfcount;
>>  }
>>
>>  static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
>> --
>> 2.53.0
>>
--------------Y8qI0IrVe0eoV2OpoNpEDctQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/21/2026 11:56 PM, Alex Deucher wrote:</pre>
    <blockquote type="cite" cite="mid:CADnq5_OCp9_drutPypO9qCLWHgxzJDm=k1PZBSTW20SNxLJV8A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Oct 21, 2026 at 7:16 AM Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
This commit implements a new callback set_mqd_perfcount
in struct amdgpu_mqd. This callback helps setting
mqd-&gt;compute_perfcount_enable from amdgpu_mqd_prop-&gt;perfcount_enable.

This is a per-IP callback and it is NULL if an IP does not
support PMC.

This commit also implements set_mqd_perfcount for GFX11.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
Reviewed-by: Benjamin Welton <a class="moz-txt-link-rfc2396E" href="mailto:benjamin.welton@amd.com">&lt;benjamin.welton@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 373c52b7022d..5ccaf805adb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -480,12 +480,18 @@ struct amdgpu_mqd_prop {
        uint32_t ctx_save_area_size;
        uint32_t ctl_stack_size;
        bool modify;
+       /* PMC compute_perfcount_enable that programmed into this queue's MQD */
+       bool perfcount_enable;
 };

 struct amdgpu_mqd {
        unsigned mqd_size;
        int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
                        struct amdgpu_mqd_prop *p);
+       /* Per-IP callback to set compute_perfcount_enable,
+        * NULL when this IP's MQD has no perfcount_enable field.
+        */
+       void (*set_mqd_perfcount)(void *mqd, struct amdgpu_mqd_prop *p);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Rather than adding a new callback, just route the update via init_mqd
similar to what Jesse did for the modify queue interface.</pre>
    </blockquote>
    <pre>Thanks Alex, I will work on this.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:CADnq5_OCp9_drutPypO9qCLWHgxzJDm=k1PZBSTW20SNxLJV8A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> };

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b5faecf13b9..04e2d857e352 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,

        mqd-&gt;header = 0xC0310800;
        mqd-&gt;compute_pipelinestat_enable = 0x00000001;
+       mqd-&gt;compute_perfcount_enable = prop-&gt;perfcount_enable;
        mqd-&gt;compute_static_thread_mgmt_se0 = 0xffffffff;
        mqd-&gt;compute_static_thread_mgmt_se1 = 0xffffffff;
        mqd-&gt;compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -4466,6 +4467,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
        return 0;
 }

+static void gfx_v11_0_compute_mqd_set_perfcount(void *m,
+                                               struct amdgpu_mqd_prop *prop)
+{
+       struct v11_compute_mqd *mqd = m;
+
+       mqd-&gt;compute_perfcount_enable = prop-&gt;perfcount_enable;
+}
+
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
 {
        struct amdgpu_device *adev = ring-&gt;adev;
@@ -7270,6 +7279,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
                sizeof(struct v11_compute_mqd);
        adev-&gt;mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
                gfx_v11_0_compute_mqd_init;
+       adev-&gt;mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+               gfx_v11_0_compute_mqd_set_perfcount;
 }

 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
--
2.53.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Y8qI0IrVe0eoV2OpoNpEDctQ--
