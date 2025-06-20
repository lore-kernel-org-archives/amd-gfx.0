Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53555C7115B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 18:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB39F10EBB0;
	Fri, 20 Jun 2025 18:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vk+Xyk9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B052A10EBB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 18:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd6jSncTemgG1cLgP21SL3AWJedo9NmE15RSuGMvd+xkyUbpEX4/Xj4SIXdqrKf50czTEKEnDF+GZcTvl7dAlqm/4TP6ESzuPlP8zekZ5aLZRL4KjgH9+vjNuDATxUewyWL9D5WzfsRYU+ABHswgvXScK9nNGWlc8j6DFJ8ondum9RUzAfQKNEFs9NECipnpYb3DHevqtQvV/HijkletryIIAQg2JCJJeaXdJjl6jbxCXy1/j1xj5W38BlHGHbaIf0unNFFfv0juAVAc0gu+a0OVXIWwxktHZlAVRq94K3a+AOQ2tELea+JtR+BJjVlonSOv+IXP7rHkuBoGIEH0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPc7ihVDUjuw1BEGrOO5SiiT57VzdsiJavEx0CDHQQ4=;
 b=NEw1E0VPYnWJmrVmREBRL+XA/jaNcCD4hPlK3EhoxrRsBBO8iTwmyiJ9cx45VrOik28k2uXtncaK5jmRvbI+xPslzHtoVfp3aGNjCXGLO2WvKpti6/tKq2C/ju1OXHj1C9usnx96dUXOcKHiASZbRfR1DPTgPbq7QeTQt/vs6TK7L8gKALodDP7HNp6+1TWU9gHW2++rs0TH0H3aau2LcP9tVjR+ojN+tmXdeZbgCHxjTrgwXtjKIKybH6M9PTOWP90UVM3uVH5FODebYyKV2PwkZwZPoRnJFFBfuzFD04OawlXejhpuK28PbdQSxNXuxKt4qgIYdlLhc0RdrZl46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPc7ihVDUjuw1BEGrOO5SiiT57VzdsiJavEx0CDHQQ4=;
 b=0vk+Xyk97HJ6HqeZBbk8DQ+aHc5VVo+G2VsrwQP3iNe4gzcBiVfAgQ8QsMaQqmBEWG4dD7TqG4YnbxGIow4WglZURzQodHT4W2hNlzyVWmQnf2N9O1Vps4hvES+NN/VkUnk27LPDg0VQIZkVT5xzqvbjMLHQn6zdYwXl+Ad/3Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 18:17:23 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 18:17:23 +0000
Message-ID: <fe77a21d-cd01-404a-a023-c448dbd49786@amd.com>
Date: Fri, 20 Jun 2025 14:17:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add ISP Generic PM Domain (genpd) support
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, lijo.lazar@amd.com, xiaojian.du@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
 <143a1fbc-8f20-4f71-8417-e838b24c1693@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <143a1fbc-8f20-4f71-8417-e838b24c1693@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To CY5PR12MB6429.namprd12.prod.outlook.com
 (2603:10b6:930:3b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfa6a5b-de3c-4ae4-78c1-08ddb026b404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzVqaEQrMHFxa0lHTmFTWGJVVGo5RlRuV21hMjVLaXIvaFFwQ3drL0Jhazk0?=
 =?utf-8?B?TzhZaHRqQkFaQk1sUHBvclU3SHc4dk1FdmFLakJhVDlwbzU1bXBLNnVXd2Fp?=
 =?utf-8?B?MGFXZGxBVXRLK2FkUndlYyt2MVpMSWN2clM0a1hOSmVaTjBxcEJkZUs2dUd4?=
 =?utf-8?B?REFxZ2RmeWFiVW1tTjVJTjM0VE5wOW1kVTJydDNFTzlpbzlIL0N4d1YvOVNz?=
 =?utf-8?B?MjkzQWlEQU53dGJkeWVZMGxteTE2OUg3WmkrRWlGWTZtZStpNVdTRHN6Nkor?=
 =?utf-8?B?Zm1oY1Fia2NrT0NCbVJmOUt6VXNwSmVvdzB4N3BYd1FkQ1JyWm5YL0w3TThC?=
 =?utf-8?B?UDcrUklMa21ZVTd4MS9Jckg3MGhKUklMSHc3UHZEOEVidHBMNHpzR3JKQlJQ?=
 =?utf-8?B?WllzSmFsenJ4cklrcUlqNzNEL1AzMGR6eXgySUJITENjeExOTW55eFlHdHlF?=
 =?utf-8?B?ck40NHM2bnpzVHlMSnNLUDRDVHQ3WHowUVZvejVtNmMwYTd1YklhRDRpa2U1?=
 =?utf-8?B?SXFwUHZkVjVvU0trRE1YVW40OXVMZ0VHb05iNmx2MWduWkt5UVJUeU1ucHRT?=
 =?utf-8?B?RUMwUUMvM1Q0aHAraDZmQTY4RWpIaDFwSW9IWDdaNXQ4NWxJQTNTdGVUOWhx?=
 =?utf-8?B?TEF6UjBBdEVJQ1lBekUzRDR1L2cvTVhaTVJpdGNpMlJNYUc0NmlOa1VIOU8z?=
 =?utf-8?B?eTdRclJvNzh2NktiZFJhNjZYSW8zQ1RISHZoYklkRUw4VHNMNk9PL2lPdEk3?=
 =?utf-8?B?cEwvOUkxR3RuUDdwQk85WUV4djQydjdFZkZXb1BKQmc5Q3crUUdVR0hXZEpZ?=
 =?utf-8?B?WGsrWnB6QUdQWUtnRWh6S2NiWGczbGlnUnRYbjZBdWdha1VXTHhzUjJwcmhx?=
 =?utf-8?B?WkpNWERyblJCTVAxTiszQWVrZTlJdnZHR0dpTDE1eUVSblNPcElQNkcvaGVT?=
 =?utf-8?B?WjY2YnprNERGdEtOSmpDZmRDKzRSVjYrQktZVEhJMlk3MWxldDdOemtwV2NM?=
 =?utf-8?B?cU9wWHJZbjVXRjdFU0lKWktWNGZsVVp1Zmxxc2hoanVXTUZ0MlliVDVhQWM5?=
 =?utf-8?B?NTZMcUdrR3JoODNjTFdXYm0yVWk0Yk9QZ25wRlJjdjRXV2ZXdmJjMjhQSTNt?=
 =?utf-8?B?Si9JV3ZzV3N3RVRpT1laNktFSVYvNzd5SXZjWjQwdnMzU3ZEcUZkWmcyVHIv?=
 =?utf-8?B?WHFQVFY4bENsbWJrc2JoV0VjNStQUjVNek9LY1NLbnhhK1FjeVc2MWYzM0Nj?=
 =?utf-8?B?bGVIZjNXTDEvRVdNY0kveE55Sm42TVBFTFRtSnEwSWZ5MUgxZEd5cmF0RzR1?=
 =?utf-8?B?YTVDTW1DT3BFdzhtaVE2bWVZdlNseFNyYnZGbFFGRXVlZUhPUjFlQkNXK0hT?=
 =?utf-8?B?a3phbStYaEM2QWIvdU8vOFA3MEV1L1ZlU3llOFJCaTFzelZWeHByOGIzaWtO?=
 =?utf-8?B?S0xPZDNibjN3ZFU1QkhvQ0hjaElqdXB4bXBjRndqYTJKcGVSbXZCWEc3QUpX?=
 =?utf-8?B?dEhGUFdiZnlpQmJLMGJpMm4vTDgrN3lITHFhOVNSaWxxWWRpc3o3OUgyOUc3?=
 =?utf-8?B?REJDeGt1blRjM05BUGFlUDJOMHd1MjN2N29uYmJ0WkZaejlMakZIQSs4TkZC?=
 =?utf-8?B?WVE5ZTc0TDVGS2FLdm96b2J0ZFlPWktOTm5ZRkd6VDV4VGR3YW5oQStXQ1JT?=
 =?utf-8?B?a1VMM0lUZkpiQjVhdXRoZC9UVWFiam9ib1RBa2ZmOWdUaHJmNWxHc3ZGMkFV?=
 =?utf-8?B?cHJZbmxOVW10TFdSUnBCRzAwTWx4bVMyQ2RvUnh3K09QOXBYMGM0TDY5UklF?=
 =?utf-8?B?ckFOakVXb1R2d0FCSUZseHZwWUZ1b01uMzlRT3RLWXQ2cEE2b0NPWkhPTWo5?=
 =?utf-8?B?aDFDald1Skd2ZGR6WlBEN0VJL0hwRDJraVE5K3l2RlhseUU3clU4aE5MdkU1?=
 =?utf-8?Q?lRMuwBSmIIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNUSFA3Y1RsWlE4Nys0OUpXdjZ2bWJPT2RYMExVcVpUR0RsQkc5WUtJRWpG?=
 =?utf-8?B?V3g4TDVSb1g2TEpWSDFIZEZxVDdwOUlzUmtnR2k4eTdoM1dOY3J1dWlnWjg2?=
 =?utf-8?B?SXgydlJYK21sT2NCbW5vOHJteTIyNkJKM3NrUytWUnFZWFdwWVpNdFZNb21y?=
 =?utf-8?B?UE1tcnJRbjZaRE9NRFNFcm8vKzJTYzZDQkthTiszOWxyeklVcC9CRldPeEY4?=
 =?utf-8?B?K3M1M1l6NHdvZ200M0JTWGFjUzFiQkRiYW9HM0JFZ01Va0pKSXFKVDM3Y3ZD?=
 =?utf-8?B?SG5PdW0weXU1NXRSSHR0Zk9IanJZbDhKYURxVFdqeDVXNjMvOHJmOWJueXJu?=
 =?utf-8?B?TE5jTExkUXpjVXE5ZHU2Y01hV2g0WkhzZlpxOTZvZzNoVlRWUlhWQjRudy9o?=
 =?utf-8?B?TW5yNllWVG5NV2R4M29EeEZ5TmFtalpYa0Rvc25wZjJRWVc3NXBCOWVOVmIw?=
 =?utf-8?B?RnJ1TWdZd2grc3dHbHRzcG9BdU56T0Nrc25hQjhrdXZRTkJNeVpFTVBhTXo1?=
 =?utf-8?B?aXA1U1ZwTU1aMTF2NUN1TjdJd2o1Y1E1R1FSR3FIUUVPSE9WTzlZamgyNHo3?=
 =?utf-8?B?ZElISk0vanNhbE14S2t3YTQ1d25JS0hrLzVrNjlXb1pwNkYvVVpFeHhGV1NY?=
 =?utf-8?B?R0JtbHFuMU9NWDNLM3N3dlkrTUFISXhqSlBJVEViK1ZNS05JTDVDd2pqMUtM?=
 =?utf-8?B?VkU5MDV0eUxOcWZGOE00Zm9Wemo5R2tpQzRWQXQ1UndTSEVhQ3B2ZXhEN3cx?=
 =?utf-8?B?TVIrRkRnMmQraHZXMDdJZTlzVG0wczVxWm9IcDlQNllFUUdZZ2Q5aER6ZkJH?=
 =?utf-8?B?cE1TVTUyVnpBYWlJSEQrb2RvTGRDaXp1dEsvOUlPSzk4M05WdERGdjhGQU5X?=
 =?utf-8?B?YWYvWXV2bW5jR3JKTldKUW8xMGU0WTRBRHNiWG5hZHpUbG8xZStKUU0rR1FR?=
 =?utf-8?B?TTg1a2Ixd0RZT2dVL0V6QnlJTVBLQnEzSzlxcFNSc2F5T0MzY240TjJZVHJC?=
 =?utf-8?B?ZFhFUk4vUEFvODZoSyt5V3k0anRoZ2V5VFYwNUFaTVZOamgyQ2k0WmxtZWQz?=
 =?utf-8?B?Y0hkczQzVTQ0TklJN1d6cTZSZEpPQmdQRW5sVnhLU0NTS3M3NDhTRkNJN1Zh?=
 =?utf-8?B?SjhRQ1ErTzYzVmpNNS9aeHBISlBXdmZoV25pYStGMzgwRnFiM1J6QVFNSGtz?=
 =?utf-8?B?WUFRMVI2LzF5WlEralpRc3k4dTF4K3pJRHpHY25XeXFTeWgxTERXYi9wczhJ?=
 =?utf-8?B?N2p0bzZmRW1iRENZdHdwaGFOZmJqMy9QcjlCM1lEMjBxcmQwaXpiVUJLaGZj?=
 =?utf-8?B?MVR2T1BUUG9VSlFSb2Iwd054UC9RTFZCK1hYOTZyL1lEZlcwdzJkczRVQ2Vz?=
 =?utf-8?B?Y2d5TW5hcDZDem1VK0RqSXNiK0RFT3ZJNjZ5MkNNZm9iNWlhQVc3MGhaLzBs?=
 =?utf-8?B?V0RWODRQemFPbGh2M1pMNFNWMFlEOGhRZHYzK2Z5S3ovUGhxQ000TlVZRnJp?=
 =?utf-8?B?NDlYNENuSmpMd3FXUjNwKzJ3RjV4UzlsZFVoODZwTTFQWTA1NkdnNWFPY3lC?=
 =?utf-8?B?UVNnVVozK092M01rUzhwUUlFWDBHMHNteXJDOUg2RjlRcGFJWDBsYmlwRmll?=
 =?utf-8?B?ZTN3cGRRVUJlWDcxTWFnRHAva3RGaHhMQmE3NWtuNlhkMFdnNS8rUXpGSGVa?=
 =?utf-8?B?MS83enJBWldZOFo1d1F1dUw0Y0I0V3Q0TjJJUXBVbFRYbmNMdUEzOE8zUm1D?=
 =?utf-8?B?TlExT3pVRVFraWJybzBHNnBMcnBzRVJoUi8yUjlkUUFCRjBnMG5jMTFLNFNr?=
 =?utf-8?B?K0h4TC8ydW84bnlmd1BmYy9sd1RJR21SSmZCYmM5clI1UWFZN2lFaTNWT29D?=
 =?utf-8?B?YVRyWnVuNVdNNi9XY3gzSml3ZUd6WWFmbXhCSTNnK29DOVV2bmNSNTBxcU9y?=
 =?utf-8?B?bUFTSUtwZy9aY3h4STQwbytlWVRQblRXUUFYTDZ2R2RDQXdCNTJsQSt4Sktj?=
 =?utf-8?B?ZHVld1ZqNFcxQXlhcmxCYkRwckRBclorS0t5MGxOTVpyUXFVSVc3amIrODda?=
 =?utf-8?B?UjRqUGdvbkVtb2pZMXJ1b1pvenJPZGgrU0hneHk1Y0hWYnFZQWhVWFgrTjNT?=
 =?utf-8?Q?CDb1yC+gl8PKUzKE48V2oPjG6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfa6a5b-de3c-4ae4-78c1-08ddb026b404
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 18:17:23.3889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zrQ9EKrj2rnMSj6II18UoXU4dZ+7YqjMQ7GtjJ5gfyKzK1kMQZwl2reSFU2oHSFXcqataH7EB3XDNsJMYl8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

Thanks Mario, Lijo and Xiaojian for reviewing the patches.

On 6/19/2025 11:04 PM, Mario Limonciello wrote:
> On 6/18/2025 5:17 PM, Pratap Nirujogi wrote:
>> This patch series adds support to control ISP power and clocks using the
>> Generic PM Domain (genpd). Its required to control the ISP HW power from
>> external I2C driver to successfully probe the sensor device. Instead of
>> using an exported symbols from ISP driver, enabling Generic PM Domain 
>> (genpd)
>> support in amdgpu_isp device allows its child devices (amd_isp_capture,
>> amd_isp_i2c_designware) to set power and clocks directly using PM method.
>>
>> We need to add support in amdgpu_smu as well for amdgpu_isp device to set
>> power / clocks when invoked from genpd. Though the below SMU messages are
>> defined, the actual support to configure ISP is missing in SMU interface.
>>
>> PPSMC_MSG_PowerDownIspByTile
>> PPSMC_MSG_PowerUpIspByTile
>> PPSMC_MSG_SetHardMinIspiclkByFreq
>> PPSMC_MSG_SetHardMinIspxclkByFreq
>>
>> Added support in SMU to control ISP power / clocks by updating the 
>> existing
>> amdgpu_dpm_set_powergating_by_smu() and 
>> amdgpu_dpm_set_soft_freq_range(); and
>> the underlying SOC specific SMU implementation for isp v4.1.
>>
>> Pratap Nirujogi (4):
>>    drm/amd/pm: Add support to set ISP Power
>>    drm/amd/pm: Add support to set min ISP clocks
>>    drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support
>>    drm/amd/amdgpu: Refine isp_v4_1_1 logging
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |   3 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 173 ++++++++++++++++--
>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  15 +-
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  41 ++++-
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   9 +-
>>   .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |   1 +
>>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   2 +
>>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  60 ++++--
>>   9 files changed, 264 insertions(+), 42 deletions(-)
>>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

