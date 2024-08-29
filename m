Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23BC83F15
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 13:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408B810E096;
	Thu, 29 Aug 2024 13:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/ZF6+b/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3635410E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 13:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHxbkwxS6utDldhwTwoZwvPS+pV9HAWq8Taq6QJ1zmZVaw+X/K+F5ADsTr9LiyKqBpSshfNyqsHQXKMKlbz8cu+jg+NQ+W7ZiDNOOybLWxZJRzyzTSLShiGgYyC7GyOepEZINqqxVocrRH0F7XGQeUsiAR4p2rRL9pakQXduvSCYtCNCsa1EmJLLw7YfSgEClcOUFgQeSwHGJ9JP2oWpPCPg2A02ebyEZXPXCDofOehfEa+mo1dAFg74SHOelEOJZELsdYHgcdtp4dd9Ek+VFvDasK9cxpGZ0YtK7AeXrmZDVw+5jT/bT0FJDfL7jH5qUMMLuGxmAIsteIwK2tcDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZPYfkFiduLilQSFfdyl80LCs0IsL1HaH7garIAZGks=;
 b=hReRMoL5yy9J/y2fsvjp83WNbSjri81ykXgNoZ5a8GiaA4DMWK+P1Ilq+EZ0u2qoBFX//6NNXWwWIKnVtmPIgsEniobCR2RMHEV8ZGttDpcBCnK9pCS8aWBeEs3T+zpTleUQFv2R4eBBjehL3PLrISO2145Qxi/z1MNkFc43EUlKUSlXyxV0wDq7G764yALr0XEqk39cAxNXDkeqNAXzBLbASBJ+U2nDSIiIspvz8LCKiJj/M7qKgXrwKayUrGAGcbOa1dElBCbXHeFzOMsnBG0K3irnzNz9fdxHHif9PB5bX8aDG+KwNz6EJkbO+e0XsmivDH420QG/qCc3dV4gSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZPYfkFiduLilQSFfdyl80LCs0IsL1HaH7garIAZGks=;
 b=F/ZF6+b/BDQ5hbfkZtQU8F9farOaKjW4BZ5D4vn7hVi0iv81QK9I/qUAfxSyiYl8aVaYJusPJn19PQ52AEqyrWu3XAtKC1AE8/6BQgbD9vvydZyb0uGGu22hB0a0hv0gDLRQy4T035ohfJMASLtfg224xlH4QByXiaXPSFyhQjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 29 Aug
 2024 13:30:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 13:30:40 +0000
Message-ID: <d72fd195-c051-8213-6876-77b64ba78a14@amd.com>
Date: Thu, 29 Aug 2024 09:30:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com
References: <20240823194901.25068-1-Philip.Yang@amd.com>
 <4d14806d-c6c1-4846-8ac3-459140d7625f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4d14806d-c6c1-4846-8ac3-459140d7625f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::39) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 089ca376-ac7d-40d4-c66d-08dcc82ec64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlN0Y1J1cEtUV1U0MVArUUd1WkJtU09WMXhvK1lRTGZDVkNLKy9HaG9rT1dq?=
 =?utf-8?B?dHlHdHNNcVZaWXV4Y1lRcEJDU2QrWlpORlRON3IwSUo4NWxqSDdSb0JZY0ZF?=
 =?utf-8?B?Y3hNZmREdVUwL0NkMW1kTEY1SEFpQ242dHlTeG9zV3EvdXNOMjdFWkQ0cXli?=
 =?utf-8?B?M1A5L3p5T0cwaUxCZ1hRak11S3FkSVYyUjdSYXRvRHNXN3Q1WDdTdFI4ODNZ?=
 =?utf-8?B?a2x1U2Z1VVo5bmI0YlU0N1BSa3BFckdjRWdVbmpUektPdEhLNlVrVmVhcnp0?=
 =?utf-8?B?SlR4TDI0WGJTTEtFSFA5YWdyZnVEM1RhMmg1M3poK0hac09HN1dQb2FTWTIz?=
 =?utf-8?B?b29GMndtazNoZHFyRTJrUzNwMHNsV2xIcHV0QlRPMHF4UDEybW1HcHFkaXNC?=
 =?utf-8?B?WnF1OWlXU3lWWnlVR25kZDFxenVDazBmVlpWbzdsVkZia0oxdzZvU2FNbm5p?=
 =?utf-8?B?VkFEYitrdUl2eVBpdnV1b0pTTWZ0VlFRdzdqVWk2RFM1dkhGVlVkU1dmS0ti?=
 =?utf-8?B?cHptUHJsVnJnMHRZYTZHYXdYYjB5ZzNXbnJqTlNDOU5WTkRCRkRZaldzQVV1?=
 =?utf-8?B?Zm9GUy8yOERLemxGalZRSUU3ZFdUS0FkZWtxb3dLWnE0RDQzN054aWdNZ1RZ?=
 =?utf-8?B?RW85em5tWUc3VWhpS01LYkkzcklVcytkelNQbC9kTmVLZ0lUR0t0aWNTTktZ?=
 =?utf-8?B?MUJlN0dBQkhtVHZ5RGxhSUZqUXBQcVN4SlB0TjdvQlVoWlJTeTBsd3JyUWZq?=
 =?utf-8?B?bExUQXIxOVRVTGhsUmY1WENaN0NJR0M2WVl1MHBNbFN2UGtzOFM5emxja0o3?=
 =?utf-8?B?VUtXblE2K1l1aUl1MERqV2FMc2diNzVGdzdkclVJOVBURmJGZDhGREtIV0hL?=
 =?utf-8?B?L3gxRWNCZC8rRDdLTWdSbFh5cUhYL09tZ2pjOWRPQjZzckZJZk9yV1JxTC9S?=
 =?utf-8?B?S1U0YTEwL2Z3R1BMUUZITjFYRThaTEltYmo1STJzbXRQWEZGTG51TkVuYjQv?=
 =?utf-8?B?dEdmQlU2aU9WY2g4NU5IeE5TM1lYMnlZSFVyRU5DcVZTYUU3SE9vajJqbGhW?=
 =?utf-8?B?ZE1ZS3oycm9ZeWlXZHZYTm95Y1dVMjRMWGpzTTZXTkc0eDVsT2c1bytkSXN3?=
 =?utf-8?B?UEIyRjRqTTlzUFVTaFJBc2lEVU9lZHJKaUFsTjV1SjBGaVlUUUVSamQ3YjBo?=
 =?utf-8?B?ckQyMHVtbHN4NXhOTjRuNXVTbkNZdVFlZ1A2ODJTaDc3aXphZ2hwUTBGb2sy?=
 =?utf-8?B?d1E3U0dOQzcvZUVYOWU2R0dTUU5FdFRzYnkxWm4zUUlsVUdHdlg4OEJKS2tj?=
 =?utf-8?B?ZDdPZFB5Tk1mRTExRC9GY1E5aE53Qm9LU3dCdzBWYW1rUUcyUHdsRkdBTVpp?=
 =?utf-8?B?Yy9TT3d2UkdTUFNKT2tjWmVTTEJpaGJ5V3FyZWNUME4rZ1hFTnhZWXdyVVcv?=
 =?utf-8?B?cnZTcS9OR0I2MFYwTFVSU0dGYWM1TCtBMEduSGF6enVqcGU4U25kUitqR0Mz?=
 =?utf-8?B?M1JMSHhnRTJZdncwRWJTdEdTMEk2OXhwTUtQcXYxMSs0UEQyZUZySjUvUVR6?=
 =?utf-8?B?cDJYMktwSnBLajBseHFLWGxSdFVCTUpWWEdRd0pLYVV6N1A0ZDhlUTk2Syt0?=
 =?utf-8?B?VnlUTmhKT2x5QWs1ZEtMNGVFRTBlaSt6UkM0aUxuYys3UTFRcG9HWFpwalZk?=
 =?utf-8?B?VFVCdjBsQ2V2VjNyRXJUdmtJUEpER1lES2FhYklUMllsK0F6WDZBZmlScFJQ?=
 =?utf-8?B?ZVYxV2h1ZEV4ckxlNzNMdHQvZ08xcUxDVHh2WHZCQVhmam5Rb3Y2dzlLeXVj?=
 =?utf-8?B?ZDdTbXBvNFkwOVJQNUh3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNibm1NenVRTWozYk44cDlUYk0yeWVVVmV2VmJOeURDQzM3NytxN2Y1a1Bv?=
 =?utf-8?B?L1QvQkJoTGRLTlEzUk9mcEsyT2tBcGFJUktSZk9KZGdmWnZtcExjTTNDUHQ2?=
 =?utf-8?B?TVVuNXVBcmFvTGdRWTZBV3lUejM0bU9wbTEwN1JUeUxoMTRvYVlXU21haExj?=
 =?utf-8?B?U3Flcm5pdDJJeEh4R2NQVmxLTldLOFNwYkRrTVk2eFh2SWozS2xXaGtDNVgr?=
 =?utf-8?B?WnlnRlNiUXdvUDlTb3BaSlkwMkVMN2NRWnY1dkg1NkkwcTJ3MEdHY2hTTzNx?=
 =?utf-8?B?NzM0NDRCTDBNK3BmYWlGRGt1L2swMEdsTThYYURmNGQ5K3crcDVkWE4wZWJ3?=
 =?utf-8?B?VTVmUUFqclU4OEdzeHk0V2tITkg4NHZ3VUUvTDhtbk9maU10aU95dzUyM1Ft?=
 =?utf-8?B?UUdnMml1YTFWZExRSHhxT1dHQ0ZPOWxWQ0I4bHZ0THBLaExRN3dYNDRhZ1hK?=
 =?utf-8?B?NWd4VDRZbXZZTWRrYVNHUDR0cnVJdXNtdzBoSk83Vlc1MHBFYXpxZGpxdjE0?=
 =?utf-8?B?TnptNm84OU5sdkVSSkc2NDFHMGtYM2Y1cjZlT1ZYZjZadU9tdnUxQVFVN0ZP?=
 =?utf-8?B?RVhEb25wbU1seDRvSTNnQkdsRXh6Yld3ckM3emh3Mk8xWEZwenNHTEtnK0lr?=
 =?utf-8?B?alRsU2ZQQTJWWmNCaTBySmtKeURzMkhFRHpyQ0dyMnZsKytWSHpTZTN2Wllv?=
 =?utf-8?B?NVBZd0RsbnVkK2hBZkZNNExXeXk2WCtRZVhXVmRBVzdkclZLbFd2MEI5c1FO?=
 =?utf-8?B?U1ErcnV4cTFqZnVHTDF4dHd0eXZUV05HVmt5SmN2L3g1cVlJY1MzSmNKR1VD?=
 =?utf-8?B?RlZYUFNXeTA0alN0OHpCZGZmcThXdWZtMGkwR2ZXT3dJMC8xNUhXZkhjYTNr?=
 =?utf-8?B?RXVOcTF1dFUrQVFHVElCQzVUcW1QSktmUVBybXh3eDBDclBwbENBZ0NpR2V4?=
 =?utf-8?B?WnBBQ2xmMEFLODNCSzhQaW5wc0xKYXhlNWV2R29EU0ZZT2pBbHU3RVNHMFhD?=
 =?utf-8?B?ZmkxY1crZnVhUkJsS0xJMnBRWGJMVi9GVGR2RTdIUjZGSFN5V0pTZnpYak80?=
 =?utf-8?B?TDZjRGVMUTR5ZEl0UzFGcHR4THRQK2FmVUtYanoxT21EQVRidkVkK1VsSHp2?=
 =?utf-8?B?WFhtWGI4SUNIOWdNaHVjYUhrdExacGdBelBMb1FFYWlJNldkYTRZZTR4c2dK?=
 =?utf-8?B?R3U1WGs3TWtoc3JnaWE1ckdINnhOR3FYaDBQOXh4VkZzSDE1N1AyNDd0Vlll?=
 =?utf-8?B?dC9tNzczMmJESm5vOW9zOW5QN1lTQzQ2UXU5dDFEWnlxVG1ZTGtlV24rQ0Fa?=
 =?utf-8?B?V01UTjlBc0s4R1RVK25LdXU0SjlkTlFSM3BCZzM1T3JBZjg1dlpsL2RxTENR?=
 =?utf-8?B?VnFFaXdrcDZ5ellJMEt0THdaUnltQ0tjSnNrK2pIOFcwNnIxWFBELzBLQkVI?=
 =?utf-8?B?b21YVlUzYjIxUXlqakpkUENMKytJdHQ5dkZlQ3poWlV1S1VaOHR0bEZZWjVZ?=
 =?utf-8?B?UFBsbjdaRDk5NHp4bnJFa0k4elpxcUN6VldTNVJsMVB2bG10Uk5rUkFpYkJ1?=
 =?utf-8?B?QThIZnZNWWh1UnpBWm1CbTJPalRsRGRJRitHUFB3OWtrcENSNlNLQVB6Rk5Q?=
 =?utf-8?B?N1N6Tnd6VThMSXJyZjFjSW1MV3hSbW1ZbW1rRkFoSUJMWlZWQzRyeXZLQW9S?=
 =?utf-8?B?REtzamZNTmRJQVJIekNTMmE0bEdZUzJQWm12WGRxeUo3Wkg2SzYrZUtkSkZr?=
 =?utf-8?B?NnF3Uk5oTlZtVDR0RmRGZVd3QTgzNnVBaW1la0Y2eXFRVlcvZkxJU0x1bjV4?=
 =?utf-8?B?d3h5bzdoYlNVeHZycUJNN1lHZHpFQTd6RGczeXZzanFPR3BDdDB3a2JzWG1a?=
 =?utf-8?B?cjNwSjR6aDdLYXlhc2RsN29VaWg1OC8vdVN5S0U2eG5lTEorekpHQzVtTzIw?=
 =?utf-8?B?V0RUM0xwbThhZ2ZWTUtXN29sS0NDVkx4T2ZqamdIUEdVQ05PalM1TE5GbEZz?=
 =?utf-8?B?MldLVmJseDBXbkdQWG5BdnorVGlCQ3R2R0FqdEZpeGVaaFdkYnh1Rlc0RFYw?=
 =?utf-8?B?Rm5JcWNZVWxxN3IxLzZicDBlMm1pZ0IxNFJXeVJhYk1pS1NEMmU5ZEtkdjZy?=
 =?utf-8?Q?bRIk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ca376-ac7d-40d4-c66d-08dcc82ec64e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:30:40.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2fCzPHgHQFR4IbTK8qET9oF9uKFZ8S2eVrK4tf7oNwwOt38iBIE9Z/zv1NI31Sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-08-28 18:01, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4d14806d-c6c1-4846-8ac3-459140d7625f@amd.com">
      <br>
      On 2024-08-23 15:49, Philip Yang wrote:
      <br>
      <blockquote type="cite">If GPU reset kick in while KFD
        restore_process_worker running, this may
        <br>
        causes different issues, for example below rcu stall warning,
        because
        <br>
        restore work may move BOs and evict queues under VRAM pressure.
        <br>
        <br>
        Fix this race by taking adev reset_domain read semaphore to
        prevent GPU
        <br>
        reset in restore_process_worker, the reset read semaphore can be
        taken
        <br>
        recursively if adev have multiple partitions.
        <br>
      </blockquote>
      <br>
      Are you sure that an rw_sem can be read-locked recursively in the
      same thread. I can't find any evidence that this is true.
      <br>
    </blockquote>
    <p>yes, down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem) still
      return 1 for successful inside
      down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem).</p>
    <p>This works fine in many path now, for example
      execute_queues_cpsch down read lock reset_domain-&gt;sem -&gt;
      unmap_queues_cpsch down read lock reset_domain-&gt;sem again.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:4d14806d-c6c1-4846-8ac3-459140d7625f@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Then there is live locking issue if CP hangs while
        <br>
        restore_process_worker runs, then GPU reset wait for semaphore
        to start
        <br>
        and restore_process_worker cannot finish to release semaphore.
        We need
        <br>
        signal eviction fence to solve the live locking if evict queue
        return
        <br>
        -ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP
        hangs,
        <br>
        <br>
        &nbsp; amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
        <br>
        &nbsp; rcu: INFO: rcu_sched self-detected stall on CPU
        <br>
        <br>
        &nbsp; Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
        <br>
        &nbsp; Call Trace:
        <br>
        &nbsp;&nbsp; update_process_times+0x94/0xd0
        <br>
        &nbsp; RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
        <br>
        &nbsp;&nbsp; amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
        <br>
        &nbsp;&nbsp; restore_process_helper+0x27/0x80 [amdgpu]
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56
        +++++++++++++++++++++++-
        <br>
        &nbsp; 1 file changed, 55 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index a902950cc060..53a814347522 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -35,6 +35,7 @@
        <br>
        &nbsp; #include &lt;linux/pm_runtime.h&gt;
        <br>
        &nbsp; #include &quot;amdgpu_amdkfd.h&quot;
        <br>
        &nbsp; #include &quot;amdgpu.h&quot;
        <br>
        +#include &quot;amdgpu_reset.h&quot;
        <br>
        &nbsp; &nbsp; struct mm_struct;
        <br>
        &nbsp; @@ -1972,8 +1973,14 @@ static void evict_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_restore_queues(p);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Finished evicting pasid 0x%x\n&quot;,
        p-&gt;pasid);
        <br>
        -&nbsp;&nbsp;&nbsp; } else
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (ret == -ETIMEDOUT || ret == -ETIME) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If CP hangs, signal the eviction fence, then
        restore_bo_worker
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can finish to up_read GPU reset semaphore to start
        GPU reset.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_eviction_fence(p);
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to evict queues of pasid 0x%x\n&quot;,
        p-&gt;pasid);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int restore_process_helper(struct kfd_process *p)
        <br>
        @@ -1997,6 +2004,45 @@ static int restore_process_helper(struct
        kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/*
        <br>
        + * kfd_hold_devices_reset_semaphore
        <br>
        + *
        <br>
        + * return:
        <br>
        + *&nbsp;&nbsp; true : hold reset domain semaphore to prevent device reset
        <br>
        + *&nbsp;&nbsp; false: one of the device is resetting or already reset
        <br>
        + *
        <br>
        + */
        <br>
        +static bool kfd_hold_devices_reset_semaphore(struct kfd_process
        *p)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_upread;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; return true;
        <br>
        +
        <br>
        +out_upread:
        <br>
        +&nbsp;&nbsp;&nbsp; while (i--) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; return false;
        <br>
        +}
        <br>
        +
        <br>
        +static void kfd_unhold_devices_reset_semaphore(struct
        kfd_process *p)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static void restore_process_worker(struct work_struct *work)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work *dwork;
        <br>
        @@ -2009,6 +2055,12 @@ static void restore_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lifetime of this thread, kfd_process p will be valid
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(dwork, struct kfd_process, restore_work);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!kfd_hold_devices_reset_semaphore(p)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GPU resetting, restore bo and queue
        skipped\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Started restoring pasid 0x%x\n&quot;, p-&gt;pasid);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setting last_restore_timestamp before successful
        restoration.
        <br>
        @@ -2031,6 +2083,8 @@ static void restore_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_restore_queues(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unhold_devices_reset_semaphore(p);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_suspend_all_processes(void)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
