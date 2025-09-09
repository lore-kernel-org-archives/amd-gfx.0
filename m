Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6A3CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09A010E754;
	Tue,  9 Sep 2025 14:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HmZcgvyC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E759B10E754
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqoWVd7q6X8oGpdPCrkqBARZQRiIzDr4Lq5T8TBhACYKmJEKu7XQRSUir62hp/DV3EHL5H7lPtv68nGP1cWoHmD7imZtrGzPtfbnXbJm+JyHOeYSeBm7kgd29OgsHnLN3OoMHLZswi5JyVMq+PYf4G/Ez9wHRphoTYNIkWM1rTvkksK1VaWwAT8D7OsqbY/hdpg04mIvEBHzhJ47eY97g3g2P4QYVqlEmmRfeJdPLdMvw9l0LeF9sCCT/YG3QLiWiWAkGPRS2XMYow8wgoxjbXhX0ZcuhvWPONTW02R7KRnAoTCkwfPmDpU68lcAk1hiy7Nb7bfVHbU6sPs7mOAYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEBQogC4mQ44Sl2oqGDaG/Xsf0bF85uSrArB2nJ4gV4=;
 b=zElp906hDs8eeGl5R/oXuqTOOkseMgj6WY6YbVk2goeMq/Kn/jMUfyy6mP0AUGDyi530NU6Ll/VoTpsEdRNlLkXGETY4NMZKP9Fjc423T27miSzDu5areniSlOcPFYFpAHnM+VNlu4qDDjaw7XErDcSITKJtI9NGDfxVqqPuIGX1rAOWl3YWOe5OGgNnlnYL891TPBHzfsIoQMV2u36zGZSZjfl6wkqqbVuPiZ+MixlFbofeNhPMGz6f9xAvABREa0zyg6JsYz1wqalsgbPqEtoQo3dG/mM+HYTluFxm6xzulMQaRdLE66RGNkvvYAFGid8tY/YDzwLYX5VZKvxppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBQogC4mQ44Sl2oqGDaG/Xsf0bF85uSrArB2nJ4gV4=;
 b=HmZcgvyCZfIeDL8hOhMcsmJNa5efolW4i0ug7SIRpGVZx8Jmyf1Ic+hOt7exzhukf/B97wMnm00cLcaR/q6Rw62mXRwT9CqvbEh7Mb5cjScCIDcX2TCcNQlraBBd9CGqJnZDvyKpb1E91u2nuApOE2CoR69B6N5FqN3AvlFHerE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:46:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:46:05 +0000
Message-ID: <ff4297c3-e6e6-c8ad-5d46-f330e4770278@amd.com>
Date: Tue, 9 Sep 2025 10:46:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] drm/amdkfd: add function
 svm_migrate_successful_pages
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com,
 jamesz@amd.com
References: <20250908161526.99413-1-James.Zhu@amd.com>
 <20250908161526.99413-2-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250908161526.99413-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f47dbd6-d0b2-48b6-2c7c-08ddefaf9a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjRpRzNJc29IczdCUS9wVHp0RUJ3MlFqNHVmRUVFZkZLeXQzRzFvMm5jOTJX?=
 =?utf-8?B?bjJxS1pMQWp2WDhPc0lZVWdtUjJxUlY2OG1EVkt4L3Zpd3FWNm5vVUlRdWxR?=
 =?utf-8?B?MjlWeWZwUmJLL1MxRFhPOFAyNllNT1FwczM4NkZFNFdYY2Rsc1FEL2FRamxL?=
 =?utf-8?B?ajMwRGdIYW1aNkNycTc4bzJUVGRaWlhQODNCcXB4Q0FCTHZMa0dTTGZ2cFhp?=
 =?utf-8?B?TXp6b2JWVnJER2ZZVzJ2b01sVWRUcXZHTy9OQVFDSi9UbEFmZy9XNmFrUzR3?=
 =?utf-8?B?N0VLMm5JVDNhTnBhL3ZhNXpqc1pPbitVcnp4bWpycHNQYjMvMTRXZEpUY05E?=
 =?utf-8?B?SGFMR3JMZ0RTc3lLeUhYK2Nudmh3QndXZnJLdVhkcC9IdGxGYkdXMVhsR2h3?=
 =?utf-8?B?Ty9GbXdQRHFEZXFFaEN0UDg3Q2RYaW91ODIzZTc0dTEyL2F2VEsrYnhJQTNa?=
 =?utf-8?B?aG5SVFVZemtHR2ppUXFBUFM0Yk56NW01cXFpUVROdnVUVCtPdnBlb0FqalZ0?=
 =?utf-8?B?MUdTSEFJR3VoZkNoUWFPTzVHOGYrVkdXSC80UDlHMWJEZ3FkZ2YzV0dDWGFw?=
 =?utf-8?B?YmplSURzNE5Kc25WbjBoS0tHVDE1NFE3VmtGMUtBTit6UEM5OG9xQVdEV1g0?=
 =?utf-8?B?ZHJLZS8yam9GWGd5d0tObSt0cWRJMjZ0Q2N2Rm5tdUptRVV6NGV0SXZ4MWhs?=
 =?utf-8?B?aGUyNUJZK2VXYWtVUCsySHQzdWtQSlVQZ3MyTldtMjgvdzIraENQUUtnVUdz?=
 =?utf-8?B?dmVKbmlVNERsSkNIS3ZRWnZtQnBMeWhiQjI5K3J5U2x5SFlUN2Z1R2ZDR1Bt?=
 =?utf-8?B?WHRpUjNDRTJKY1VCcWRxWi9NcmxEbCt6L2xKUHFKRW8rQjdIT2V3cDY3dEl4?=
 =?utf-8?B?OFFIQ2V4bmRvbWc2Q2NzdnRIOHhqUnBQV0dWblB4RXlVMEpiVStmMEJWYkFs?=
 =?utf-8?B?OG00R1NFNngrcHBTNHh4MEEvd0Q1cnlsdkRzaGxrVEk2UWVtRk5NN0tvQkpW?=
 =?utf-8?B?ZnpjUGkxZTArMXpQRzJDRktFRW8raVVOSnQvU2R0WmVzUEJqSDlOeS9WY3Q0?=
 =?utf-8?B?UU1vM1ZtR01vbGt3cXBnRTZjTFN1ZkF1WllYSFJSZnQwcy9tRTdtbThzVUti?=
 =?utf-8?B?czlvdkJNQ1A2cGpQMDdPa3oxeG5ZSEsyc3prYU1rUGczOFF4VkZKdmpiMGZZ?=
 =?utf-8?B?eTZaV3BJWS9vNW5CUEtlcnh4VGhIak1sVVNmcXc0YitjRll0Vmt5TXBIVm9n?=
 =?utf-8?B?NVY0aWRYSE1yMEZLSGNGNTMzQ2cvbzhEaTBYaGZ0VE5VUGQxOXFOTm5yTXBW?=
 =?utf-8?B?UTA3S1htUXlDVkd4SFUvYWVSOE12WVVGNWN4SENxWDZWZCtRek83Mkx0TlhJ?=
 =?utf-8?B?NDB4cEd5U0tGckE3QWVXb3hiQ3phYUhNdUtYakZlNGVUNEpEL2tBZHoxcVdP?=
 =?utf-8?B?K1plMDBMNWtjQzlwblNCNjlNSzlBMHFDMjBlYk9QZTM3Q1IvMEM1MmlOZ3lH?=
 =?utf-8?B?d2FEOGw5R3liNit6TUs1L2ZBTk1idjJSS0s5emEvS0MxTDRwMWJCMmV6ZS9l?=
 =?utf-8?B?Z3RPeHRUaEhPQVhVZGFGTHNZWjZma0RCRDVlRTVNM1lQamt5OFI4VWhWaVAy?=
 =?utf-8?B?OWZBK3B4Nm9nSmU5RktTVGVEOHQ3c1VDdnhvQUR5UzZWUHpDK08xUys4eFdl?=
 =?utf-8?B?MFIyMndjdmFUTGhCS1VrR1JoWXZTU1JPQTlEMHpTTUp6cWtYZUZ0TzZPZk5z?=
 =?utf-8?B?T0JQN3JVdUp1SW8xUXgwd2RnRGtyeFJ2MDdVeU9KRUg3SndFTy9HYjNGV0hK?=
 =?utf-8?B?MzNnTHdqTE12czNHYm9mV1greWFKbHk4VGF2aEZIUWduS1ZtdXltdHYyMGdX?=
 =?utf-8?B?Q3lQSzRmcSthWFJMQ2NsWWlETE5ubmdVQlFoYjUyMFdMd1Z2amlKUjU1cytF?=
 =?utf-8?Q?eQizrPdTDhU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5ydVdPUmVjeWI5bUxKOGZXdGZNaEpLZXU1ejZ5cHV1VFZ6ckNwRTdnOHVQ?=
 =?utf-8?B?RXlpUGtOMTl4Y0E0UlVNWGZwNXlDUG1WcVZWZGR0Vkl0MGRwZTNQSGVOU1Nj?=
 =?utf-8?B?MGo2S0JHMllsb2pFZmV2YUlNeUZjUmZQbE04QjB4Q0VnYzg1d3Mrd2lMc3My?=
 =?utf-8?B?L1FTNUUzWHN5Vy80MTE3Y0czRTNCa1JTRHMvdEdqM3lLM2Ntb3VJYlFqMk44?=
 =?utf-8?B?S0JFaGt6WjZqYVljN1E1bk96OWllK2JpaVNNNEx6aXJidUtGVFA3R0xwUkxN?=
 =?utf-8?B?cGpOZE1EWjhnSGxtdjBwUUlPL1Z4dHR4cU1aOTJiVWdhTmtyVE1Wd25kSzV2?=
 =?utf-8?B?aTg0a3E2enFPKzhBL2Z2cFFVby9DNU8xUlE0azY4YlQ1ZnZndkZkZVorTVVj?=
 =?utf-8?B?SlJaZHJxT1VEVlM2L0R0SXlRUUVhNUlObURjeCtsT2hXZ1g5MTV0cWZJYnVC?=
 =?utf-8?B?Y1lYdjFleGlrOHZPMzdsWFBHVjVMR0dWUnhuM1IvMzVzRGpjRXFURlhhM1Mw?=
 =?utf-8?B?T0EvcHh5enk5VEgyRURCMXFONWVvL0lDYnJqN2JUK2EzMTlQNC94S3VDeFhs?=
 =?utf-8?B?RVFBT1MxZk9RMmJXRTdUYTVFYTVXbzNibDU3RUt5emk1eUNCUFl4OG0vSFpZ?=
 =?utf-8?B?ZkI3amxMZ0NrbFVsSWxuZGdLNnhlSVNDTFd4YllBTTlzd1RVQURzZWdtNFhL?=
 =?utf-8?B?VDFKcjdlcUNHWU11SE05UTlDWTRRNmdub2lFdlNVaHJxUmRwb2lSWDVXUVV0?=
 =?utf-8?B?QWRKZVcvaWJSVmVYNSt5eXh4WHZqZ2NtYVFzczlxNGw0QlplbjRaaUNhM2cv?=
 =?utf-8?B?Q25iVDh4WnNZTzBlUVJSUktVRnFWeVBOVnFsbW1uZXlsWUdqbmVsWHl6S2dj?=
 =?utf-8?B?Y0RPeHNoNlhHOFlobUdYaXBUSEI4eWQyMXd6c3Rpa2FoaWcrQkFVTkVyRVJJ?=
 =?utf-8?B?UlAvOGtSR3k4em85UnZ1RGp0T1BrMlJObFJJclhWcFIyUzNwbWNXSFZ0NCti?=
 =?utf-8?B?OGdVYkl3aSs5NmphM1N1V2poSFFSMW5mOG5TdTI5RERNQkh2T0Y4b3FZRVln?=
 =?utf-8?B?NlhNYlBPS0M2b0hLUkJxUldJRnE1T2N4M0J1MCs3NVNSbmRza2QvN1hHeXRW?=
 =?utf-8?B?Rml1Nnh4TFpja3o3ZC9VZi8waWVyVnBwc1JRU3JnUXFEM0FRbTgyOFh3SGV4?=
 =?utf-8?B?eW4zNXlhandzd3YzTDFRYTl5R0tsMFoyUFVQdHV0eHV4TlQ4TjdzdjRNSElY?=
 =?utf-8?B?R1l4ODRVVUpTeEZyNG9FaXlZNjQ4SXNzZkdCSEVIUE8zazVSRHoyaW5pbkEw?=
 =?utf-8?B?cCtBaEcrT04zeHFjMkh0RS9WSW41ck1WbXN4Wjh3MUVDbkFSRTA1N2E2R2Rz?=
 =?utf-8?B?MWdCYS9OSWQ4aHprZ3hQY3JBditxbW5rczRJbkVucGpYL1dMd2pJTGdsZ1Iy?=
 =?utf-8?B?RCt6KzI4OHRObTBleGZ0WS84U25BNkliaGNZSExxdDFBMXoxem1RNDQxVUVj?=
 =?utf-8?B?WjQySytrendjYXVIU1k5bVVmSERweVFFZTQzS1ZNaWhEWkR2SVFQbWpUK2xK?=
 =?utf-8?B?MmEwc3pJcmZDdXMza1kzblAweTJqNDJoeUsxc0Z0TmJjSnhDQlBMR1EyOVBI?=
 =?utf-8?B?ckhCQXZMaUFnT25QbUlyZTc1bTdVREVUSmJwSzFlVjlFbHhwNDJaNXpFNlZJ?=
 =?utf-8?B?K3JKMkZGc05QMVlVUEZ0ZE1ZTE9yWUV3V1BjOHAvdlZ4VGZZNFlrS2tVcVBq?=
 =?utf-8?B?WnRxM1hUVU9hTGpFT05hR0hVT09leGt4Z2lLN2ZZcS9jekJOZllIQUFZcW5P?=
 =?utf-8?B?WWRGeUhlMUc0dC9lVmhxZXFqN242RWlWVTVlcWxYTUxvRzF3azNpS0FmSlow?=
 =?utf-8?B?b1UySTYyWVpJcmxIbU5MdVp4R0VtK0E3RkxUc2dCRWFtRTNuRlo1S0JoeC9P?=
 =?utf-8?B?ZnVzSWF4UHAwVUNLczZselNuN3JoTUhnbEFQMzFPVkZtZHk0aHZ5UEZadEVl?=
 =?utf-8?B?WmIxSTBVZUdSQkxYREJ5T2xPV2E1SjNaMnJIaHhmZ0JFZGVjTTQ1R2JLeEZ4?=
 =?utf-8?B?ME9XWkoycHBDQlBkWTd2SVZ3T0lIU0xYVUFYdk9Gbk1oZ0g4cnUya2F6Q1lu?=
 =?utf-8?Q?mT2M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f47dbd6-d0b2-48b6-2c7c-08ddefaf9a98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:46:04.9789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLwMc2/rJo7tcY5sRLM3M44QftNM5ZtRHDvvYlgycGNlnFRbfUufk67tUNVrILaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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


On 2025-09-08 12:15, James Zhu wrote:
> to get migration pages. dst MIGRATE_PFN_VALID bit and src
> MIGRATE_PFN_MIGRATE bit should always be set when migration success.
>
> cpage includes src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID
> bit unset pages for both ram and vram when memory is only allocated
> without being populated before migration, those ram pages should be
> counted as migrate pages and those vram pages should not be counted
> as migrate pages. Here migration pages refer to how many vram pages
> invloved.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++-----------
>   1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..83b9d019c885 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,17 +260,18 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> +static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   {
> -	unsigned long upages = 0;
> +	unsigned long mpages = 0;
>   	unsigned long i;
>   
>   	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> +		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE)
> +				mpages++;
> +		}
>   	}
> -	return upages;
> +	return mpages;
>   }
>   

To fix the incorrect page counting, maybe add this check in 
svm_migrate_unsuccessful_pages, I fell this is easier to understand than 
the condition added in svm_migrate_successful_pages

@@ -278,6 +278,15 @@ static unsigned long 
svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
                 if (migrate->src[i] & MIGRATE_PFN_VALID &&
                     !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
                         upages++;
+               /*
+                * if migrating from vram to ram, don't count device pages
+                * which are not populated, this could happen if svm_bo is
+                * evicted.
+                */
+               if (!(migrate.flags & MIGRATE_VMA_SELECT_SYSTEM) &&
+                   !(migrate->src[i] & MIGRATE_PFN_VALID) &&
+                   migrate->src[i] & MIGRATE_PFN_MIGRATE)
+                       upages++;
         }
         return upages;

>   static int
> @@ -447,8 +448,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +	mpages = svm_migrate_successful_pages(&migrate);
> +	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
>   
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> @@ -688,7 +689,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> @@ -748,9 +748,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	mpages = svm_migrate_successful_pages(&migrate);
> +	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> +		mpages, cpages, migrate.npages);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -763,8 +763,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger, r);
>   out:
> -	if (!r && cpages) {
> -		mpages = cpages - upages;
> +	if (!r && mpages) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -847,6 +846,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> +		WARN_ONCE(prange->vram_pages < mpages,
> +			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> +			prange->vram_pages, mpages);

It is good to add warning once here, should we also change u64 
prange->vram_pages to 0 for this case, otherwise this could leak svm_bo 
as prange->vram_pages never become 0?

Regards,

Philip

>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
