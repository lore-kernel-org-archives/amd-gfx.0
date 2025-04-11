Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E100DC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 05:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD8D10EAC4;
	Fri, 11 Apr 2025 05:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YWB+UXZQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA3210EAC4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 05:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in2vU3zR491ahqUywaJxP8Ft04sgdUQ4TJC1zzjWAE0W281dSez11sPpWqNHapY8doxrYH1Ubu9BX3aDsBklJT23djXB+VCQuNDv62gdpyEkUbH7Grs0VopanoJLjP9VkfwQ/nvyCQXZA49vLg5K6GGaOqVsuTVIV+cJlJczD5mN+JAgmYMh+HXVqVJkxYQL+3FXEJFRuprdKZyupvrDWZD7sZNfiMD7kh62BfxHUfZkzvFNc77QMtLClnLcZNo3TdETdJbYeq+tOU8MRMEDzhnNLYPl/OV86zxrLx9mA0QsOWYiopbN20v9VtXKuEqV+MW+FJXeo9vBXYdDep2vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v989ORsClzVq8m1SyDbuUUv7/wnnzYQm5zYA0pUpEAI=;
 b=MSwlcwXX6jR3tZzLN5K8Dn4v4SpsBSiPIY48uWEHv52wgQMG2rONw67JW9UFDcuAM4BVEz6VadT3HWED/iUBlW1+KbbZZg9CDhoKB2Eegn7dKgRnwTJPx7po78WT4oOtnCPAVVKzfGvDg6Hgn5liwRnEdWdIoqSlSKkCg8xK4ZHwN2iRw8YYItl1NtgqgOkdf0p1LIG28oJCh8Sb/qR27iWlrqJm8JYkZaN95dMcsm8OFDdWBqCxFQ9S8vXS8v0r5LAqTCwZMdqzDv+hWIFW499QUeXDy7z4I5NjmK3Ne8cnOUxDiol1mBzeiQ4JIFFX9H6Z90bq+aXxSADyiR2cpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v989ORsClzVq8m1SyDbuUUv7/wnnzYQm5zYA0pUpEAI=;
 b=YWB+UXZQoHRyCtAAo7qJm+t83AzeVjDYAT8ZXf5dX3WqlPMk1qAhnoNsVeJHdhvbnZgn6fkDI3nc4tUTBKC5+ktERadwEcVNC1QXOq0guWXZrGYkaTC9SK06XDoodWj2dpBmWGhKmvv3ZegdktOJAe2sYPxCtemybPsXggWzMPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 05:17:26 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 05:17:25 +0000
Content-Type: multipart/alternative;
 boundary="------------RIK073pq4QH8RgzwmWO65cwV"
Message-ID: <a9476ade-2913-4f28-b8a1-cba33bf34a99@amd.com>
Date: Fri, 11 Apr 2025 10:47:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250410145750.51421-1-Arvind.Yadav@amd.com>
 <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
 <BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN4P287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::14) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: cfff8f84-5b4c-4b4a-f72d-08dd78b8255a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K212Y3ZJWFVkTTZ6VE5FVWpwUUNGRVRCaEduSFZUVUlqdG40c2NQZTlNVVNu?=
 =?utf-8?B?RW5LUDF4U2NNRWFqWEg5bldlWk8zdHhwNThJL3pTY3NqUHVqeXQvWktRUnVR?=
 =?utf-8?B?UXhJc1plMDhWeGFJVm9SUzZnNG9TUmJVWHZkWFhjNHFWVUw0ZDk4elF2ZkZi?=
 =?utf-8?B?K3ZwSWpCMVlkUERlTU43cCs0OXlwWjc5bDd6czIrZzV1WFZJSlJxQWRNL1dz?=
 =?utf-8?B?K1N0MVJkSlNqN0F5ZFNDQmFGYmJoajljaG5aejdnN1AveGlJaGYzODZvYTRx?=
 =?utf-8?B?cnBqMlNmVXZRd2w3MlJsSHlTbGZzZ2FsZ1h2WTVnc1ZmM3pkQmJMdEJYMktG?=
 =?utf-8?B?TC9PQVhjUlRhREtZaElRYWlJZXpyZjdIUjc2anFnUVRaTUE2QjFIQmVkZnNU?=
 =?utf-8?B?YitTMWVaSTFyMytIeHBSN3QwR3ZMMzhhSjFmOTdkL1V0RktxaC95U3lYaTg1?=
 =?utf-8?B?allTMHIvVGk4ZTBaLytRcExxMVNTc2JXcmJqckpLckZIb2VWSDFKSW5qMi96?=
 =?utf-8?B?UE5oazJScFd5bXhhVkFTK3FRTS8vc3JkV0IxRnhya21DdGk3cVZHWTliTnc4?=
 =?utf-8?B?UXJWVEIyaVZqTWZkdW5kMU81Y21Lbm12Rm1IMllNYVlCNEhhUEwvU3Zma1BN?=
 =?utf-8?B?RTFZaFBQL29qc1lCRVg3cFMzR2s0R3hkN0NITlJoK25aK1dTRWFkdlREQ3dG?=
 =?utf-8?B?UzVvRmR2TmZ4MWFLbHBVZWF5MG5TVnp4VEl0enpTY0hXNWZKQ29oZ2xJMWVX?=
 =?utf-8?B?djlOTXN2ZzlLWGp4cm5EWWt5WWhabEhrM09iN3JGNUd0d3VKbUl1d0JYbXlK?=
 =?utf-8?B?ejdTQ3Fjc3RWVnJ6RUdBQmhBZGROM2VHSmJTQzB3bi90Z0ZJVFZrSmVDaVNH?=
 =?utf-8?B?bFU0dU1yVGFZdjM1MmI0Z055N0hDUGtvcTlqSDVrd3M1WENROUhTanBkV1E4?=
 =?utf-8?B?OGVycnpobVlhSm1yQWsxeHVJYktMODNJS0lPRUdXRWhqaUoyYUdxSHlBYjFJ?=
 =?utf-8?B?OVcxZnp4M3VaVS9XRk9PVDU2b2JVelFPNnA1cGhhd1NUdUpYOXBKSmFJU2tq?=
 =?utf-8?B?RG4yY3VyaWFjelQzTlZZOGV0bU5DT1dkdmsweXRpZkJzZ2VMWDJCUUZXYTRC?=
 =?utf-8?B?K3A4d2FLaVlyaEhBZnFrVU5QbDFlQlhYZkk2MkpmZ0ptcXQ4TEZwSUZNM2Rm?=
 =?utf-8?B?ekNWb3pkNDBNQnhNUFlDM2x1dmVvbDJ1Vm9kYytIT1lRVXpKNlpDYVlmQlJa?=
 =?utf-8?B?T2tkdnBNMWxJRWxTaklQVDd3Ky9HWGJHMDFSeDZEYnV4YVFVTlg2NThDSjVU?=
 =?utf-8?B?N29iUnJ5aThibTFxSHhpT2hIOUIxVEVoa3JOVy9FdzFWczFPcVpUaTlwYU9q?=
 =?utf-8?B?aUx4WkhxeDRwdjNRYTNKWWpvWnhTditqTG9TQmJPNWMyYUlNYmQyRHpPNmlm?=
 =?utf-8?B?ZmNQTysySzBocjNJazgzOVhmZ01vOTVmVm94T0EzUUlNVXRHY01vaUxPcDN3?=
 =?utf-8?B?ZFNpT0Ntanp3czF6WkkrK2ZqaXdrQ1RWZlpVdUcwcVZMYWxWOTA1em15V2RZ?=
 =?utf-8?B?VlZyd1hSMmtRRVl6VzVJOSs2VHAwQUhSendtanNGN3ZCUGJKeUUySit0R2Qv?=
 =?utf-8?B?ZUUrdU84WlFraEtqUUlmYUllMUUrakRjTHhVNE0yN3lrM3ZRa3p6U3BtVnFN?=
 =?utf-8?B?QXVmRy9TZUUxM05zdWk5RE5hTEtvUGdTaVI2Tmtoa0Y2WGwwNzZxYkdpSUhJ?=
 =?utf-8?B?YjZrRHZXdVJhbmU3aVVicUZKbDc0ZnR5QS9UWWVhRkVpQ2wyc1lyQnJlcHhm?=
 =?utf-8?B?TTZUZEtzcXh0b1YzcmJ2bDV6bys4akd3dC9Fb0FSU1VwMmVyamlkS3M0RmFm?=
 =?utf-8?B?dTRwMzFVNmFMS0dmRXdrVGZoMnVKQ2hYWDdJaVo5ZWJpZjdMZTRyMW94TmhD?=
 =?utf-8?B?a0FSc09HWkxCUmlqcHo2Zkk5amRBUnFoTlVZamQvV0xtUnArVEtudEduNk5u?=
 =?utf-8?B?dHdGQktNUXF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdvb1VERmd5dEJHaUhMVWVsT050Y284YzU3R2oyUjVEeXNMSTRnanZwNTBN?=
 =?utf-8?B?UnBtM1BZbnBEc2J6U1Fja3NtRUpMTS9XeHlaSTRBK0lrMnVTSHY3dUxqUGpR?=
 =?utf-8?B?aXMzL1h0NzlyaUwyQkR0VlRPSGpJTHU1V0VLQ1NpcktzdXZocUE0aG04Tm5Q?=
 =?utf-8?B?Y0JabVBHd29DTFVoUGc1RnNxK0FXM0szSEZDMTZQUmVJTm9IK25RNGduRm1x?=
 =?utf-8?B?ZnVuTlJCU0NPMURGWnF4ZWxzZEVRNW9CSGtRR05PdmtmVUJNQitncTlndk5N?=
 =?utf-8?B?SE9hMnlyZndYMW1va2oyZzNvak1vT3FqNzR3N25YS0QzUW5BK1dlTU5ScTFF?=
 =?utf-8?B?b1FwbjBUVUx4cjhtOFJ4WmIwS0ZDM2FVVDJIS1pzVG5JQkhDYmx5ajd2OVhW?=
 =?utf-8?B?MDdpSjRBS1E0MzFsQ1poVHkrQmRJOEUyaVJQRkhMU1JQTzFUUGI2RWpNVlVm?=
 =?utf-8?B?OUNFNlkwWVd2SDZ3YlpjRkZSNUFscHlHdUpBbjZyTjhncmtFNDZ1amVUckZW?=
 =?utf-8?B?aW1sVk1qWFhFTnNiZERnbElnTVNuem5tTERvWFhWdElpRzNlazZUMXdhUVhX?=
 =?utf-8?B?U25VYWhQWUZMQ200TkdYL2tFTjc5WlJoMEVnTW14WlBGWEJhcU5HSU43T3Yy?=
 =?utf-8?B?NDF0SThNb0ZoMWNtbzMvNDBvNm1maE5yb1dXbkREWnJ1cmUxVkhxalM5NGdq?=
 =?utf-8?B?N2ZKS1RldEs4cFhKdUxRMEo5NmE5bTJEMkF1S1F3MnVBV1llSElhL3h4QVdW?=
 =?utf-8?B?bzRQVVMzSG41RFNQNkd1MWVtRURZdmErM1hsRkJ3VEQveG1ZSGgyd0xSdVJo?=
 =?utf-8?B?QXhxc25DOEVjeFdaVjlnYVdNMkZvOXF1dkFSNWFRQ1ZJeEdBSE9jakJjcEcz?=
 =?utf-8?B?SEZPcTRldFRJelFuK29aWHhpWmhMaitYai9oNjZTVGpFSnZwRnhFaDdOVVhS?=
 =?utf-8?B?cEYyVktIZnhDNlNsTW52S3FFdlFXR1BUSDVEZ3gzVlFxdWhTWFU3S1BwWk9h?=
 =?utf-8?B?aXY2RXBlcitjeUdoeEFxQjlxUWs1WUhWaThpdGtuUG1RdGtsMVZydU9wdUxQ?=
 =?utf-8?B?RWdEMUlJMkdRV3pxbytGaGFza1lwRlVoeTQwZUNCU0xMaW05WlIveVBJTUU2?=
 =?utf-8?B?MFZCVE8rQjJmT0wxOEFtQkdLSm41RUJoMWdUMTYrMnloMmRHcXYzS3U0Q0I4?=
 =?utf-8?B?NGN2Nml6dlRwWUx1YkxXL3VjKzJTbjREUjBmTWQ1SXliZkdxWXI0dlR1OEV4?=
 =?utf-8?B?U3FDNmt1VHh1NXc4VUxCTzdmZ2g4MmUrZVRBbXZmNWEyck0xc3dUQnBRUXdp?=
 =?utf-8?B?dSsxajVVRmlZa3Y0ZUlRNDZhZ2RER0JpcFM2L2tlMXo2dTAxVmwzTUIrb05Q?=
 =?utf-8?B?NVBsMzgvYzZNRjQ0Tk5pUGVDbVpuUHVjV2xISnNWMHR0QmNsQkYvR3Jobno0?=
 =?utf-8?B?aU95TVg0RjZjSVlzYVZVYnI0cWJ2UjZDSjl5S3RMTmFBb2RQc053dU1kM0Fj?=
 =?utf-8?B?T0ZwMStGSkMweXVUUEVVMmwxVkJ2MU9FQ3BFUFZ5ekJwT3B3QnhIaExMQzFp?=
 =?utf-8?B?MVprWjVXWkdSUGora0VBVXFuT3FZUTVSK1ljV2hNSXJBR3VieGJLZHM3d3VL?=
 =?utf-8?B?OGIzR2tLV0w1RExFdVdwMllKL3F6dlR3Zmp3MmNTWFRwNUNGQUk1SzlwVCs0?=
 =?utf-8?B?OTg4c3d1Kzl0NjZkVE82azg1V2N0OG5rWTBPSDg1OFFLQXhFcVdCdDJBTGdt?=
 =?utf-8?B?bWx0d2lpSDljSGtiUkRTQTJ2UFQzL1gzKzJJYk9kR3FONGRSLzA0STQ0RzN0?=
 =?utf-8?B?YnJpZUNNKzR1TENPVUNkSjlVanBpRXhrTTY5TTNuQUFJemliMVo3aUVvK2VN?=
 =?utf-8?B?VXBWN1RUaWZ2bWlsM1pMOWhreW9ZQkozYUVxajdBS3BvNjN2N1k2MC94eDlq?=
 =?utf-8?B?K3crKzdXTkFleTFBc2IrdzhMdFJmLzhrL0EvK3AwODVTYzQ3YkIvMFhqS1ZC?=
 =?utf-8?B?YkM5eFAybGRRQUJDaE5oc2FIOHlpL0FyNHBGaHVTVS9Gem1SYWhWMmc2Qndo?=
 =?utf-8?B?KzlkWTVvbXQ1Yy9UT2hjQ0F0UjcxVjNGWjZsckE1d04rNC8rODlvOU5mOWxx?=
 =?utf-8?Q?fok6leSPn/M/mJJU+S5GDe/08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff8f84-5b4c-4b4a-f72d-08dd78b8255a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:17:25.5525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2y8x6gzuD2ZqdAuhtjediO1yNmkJzYNZpcpa32vryIsYV1kBaTEjig/rzNWHfV19JfWtf9ANGy6RKES7Rt1stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

--------------RIK073pq4QH8RgzwmWO65cwV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Series LGTM, Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 10:25 AM, Deucher, Alexander wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ------------------------------------------------------------------------
> *From:* Yadav, Arvind <Arvind.Yadav@amd.com>
> *Sent:* Friday, April 11, 2025 12:54 AM
> *To:* Yadav, Arvind <Arvind.Yadav@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; 
> Sharma, Shashank <Shashank.Sharma@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check 
> for usermode queue
> Alex,
> This is v2 of 2/2 patch. Please review this.
>
> ~arvind
>
> On 4/10/2025 8:27 PM, Arvind Yadav wrote:
> > This patch is load usermode queue based on FW support for gfx12.
> > CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 3050, MES = 123]
> >
> > v2: Addressed review comments from Alex
> >     - Just check the firmware versions directly.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Shashank Sharma <shashank.sharma@amd.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 3d87e445270e..3165fdfeca6a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct 
> amdgpu_ip_block *ip_block)
> >        case IP_VERSION(12, 0, 1):
> >   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >                /* add firmware version checks here */
> > -             if (0) {
> > +             if (adev->gfx.me_fw_version  >= 2780 &&
> > +                 adev->gfx.pfp_fw_version >= 2840 &&
> > +                 adev->gfx.mec_fw_version >= 3050 &&
> > +                 adev->mes.fw_version[0] >= 123) {
> > adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
> > adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
> >                }
--------------RIK073pq4QH8RgzwmWO65cwV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Series LGTM, Reviewed-by:
      Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <div class="moz-cite-prefix">On 4/11/2025 10:25 AM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB51446C91686B8D6B3E3F7A0FF7B62@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Yadav, Arvind
            <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, April 11, 2025 12:54 AM<br>
            <b>To:</b> Yadav, Arvind <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a>;
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher,
            Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Khatri, Sunil
            <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a>; Sharma, Shashank
            <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a><br>
            <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 2/2 v2] drm/amdgpu: Add fw
            minimum version check for usermode queue</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Alex,<br>
                This is v2 of 2/2 patch. Please review this.<br>
                <br>
                ~arvind<br>
                <br>
                On 4/10/2025 8:27 PM, Arvind Yadav wrote:<br>
                &gt; This patch is load usermode queue based on FW
                support for gfx12.<br>
                &gt; CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC =
                3050, MES = 123]<br>
                &gt;<br>
                &gt; v2: Addressed review comments from Alex<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp; - Just check the firmware versions directly.<br>
                &gt;<br>
                &gt; Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                &gt; Cc: Christian Koenig
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                &gt; Cc: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a><br>
                &gt; Cc: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
                &gt; Signed-off-by: Arvind Yadav
                <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
                b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
                &gt; index 3d87e445270e..3165fdfeca6a 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
                &gt; @@ -1418,7 +1418,10 @@ static int
                gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
                &gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add firmware version checks here
                */<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (0) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.me_fw_version&nbsp; &gt;=
                2780 &amp;&amp;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.pfp_fw_version &gt;=
                2840 &amp;&amp;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec_fw_version &gt;=
                3050 &amp;&amp;<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.fw_version[0] &gt;=
                123) {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX] =
                &amp;userq_mes_funcs;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE] =
                &amp;userq_mes_funcs;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------RIK073pq4QH8RgzwmWO65cwV--
