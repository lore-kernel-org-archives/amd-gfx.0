Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047BEC47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 12:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E50D611CA
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 12:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E50D611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4684A6E063;
	Mon, 31 May 2021 12:02:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E5E6E063;
 Mon, 31 May 2021 12:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB/NRffwU5ZT7UjvWFEUtajoG7m5upYgRIzkxpZWk95MSR5Zvsurtxrtito9ZFKGMiIUi/R+za6RrWrGFeqp44mcZcYjdNFbBXVusHWAcIrAwqKNtJcNzIg0f24dllxzqfPgFyHWXAuFCpWXupDxeuGE3UQOimyYWUgEfPM1p+2kKqmOsGjcml2n9Lc8lQo8XOEVtZA2QjtgPOkN/WCsn6ZNXIw++ndhxuOSY3N1on2w0VbA6XoOqP5Gni9V/gE5xmDIGURvbU8YXBavkP/NrlT0rQsR3RyI8NY4cArsFTwLKJOp2zlBH8cdKPPd+z87CYery6CqbJex4QkjP9jfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMNWLBMaThJ4OPfS1ecljoXrMzkCLhBum7RgmkoWPRg=;
 b=MOyUhjsAbZLQD+Q1rhh+AGIvcwOUGRglmv8OwWRc9df8hDCsR25K03Vxxr0oZ1vY68beoSeu3LICcxQI1Po+YGaz74yq52Yb2A8khWVFlf3grnkuITez3mjVnsz6Xh/a6LzCbuwzsHMSC5rYiY5u6gGGFEGADF34kyXaU4ZKuJ5EYxIuz3vHa9tUaAIvB3f27355ZXIiZmxtP+ybwNSCqHxGQja76hvNezywDOe9BHpSQqQ4eXAyJekx2+NtkuT86WPg9pLHwWPYUrGYrc6DV7isdxXtOoBa0owMPtXfSLgcFuJmQwBXkkGv3mLxs4M5+G5IHlSjvsI1rmUajUzsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMNWLBMaThJ4OPfS1ecljoXrMzkCLhBum7RgmkoWPRg=;
 b=Hz3FpuTZs/YPQ4eZt4wFG1IFFw2aToRk8wjuVJrz/9kqJaQFy+pZlGQF56GcbixDTNA1a7mvKMPYH05KpN8X1T/DusN8ryx6yCM6UpXC3jJ+YssvtGbj8vNyczZY6K2tlKjPL1zZ3pwhsKq6gYwKsoQ0hhcF2zY77BDt/D/50wo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Mon, 31 May
 2021 12:02:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 12:02:19 +0000
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
 <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
 <86054733-9b7d-de96-4ab2-21dca85f1e6e@shipmail.org>
 <888c52a5-ec10-0dee-c462-93cef8510e9f@amd.com>
 <6c4c8c57-7cc7-7e24-1d19-b91a312d44a0@shipmail.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cd081dda-7430-d891-6b02-8aedda7b67be@amd.com>
Date: Mon, 31 May 2021 14:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <6c4c8c57-7cc7-7e24-1d19-b91a312d44a0@shipmail.org>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:b94:4956:bad4:7c81]
X-ClientProxiedBy: AM0PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81]
 (2a02:908:1252:fb60:b94:4956:bad4:7c81) by
 AM0PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:208:ac::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.9 via Frontend Transport; Mon, 31 May 2021 12:02:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f703bfe9-661e-47cc-56bf-08d9242bf0dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566AF87D7544313D6966A80833F9@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y14ct95xvGO2AyTmhf79F6oZ9iyBvrO5FJt9KiSkfzj266ntXDkY8cfc1/GSqaVaO/en+jV3765mC2KyxV7Sbzf1T1P4G9bL1BeNmNNg2XAd1nY+BblJn2ItFCj9kyXEyuVw3f6LMp5XQ0O9/rK1cXGVtFhtaUZPMCEHAAGwjTTHm6ELwOqQ7ia7tNA+QDL2YW1Djq/8KNqaaJjwmSq9SgrguUhQn5BzicUNQlAkEuZKkEXz0aHiMpnxa6/li7orvEqrLoUZJV7mSJMvmLLJbEKFiov3N9zRYzg4wB4QZ7xn+TyYcXMcdrpGTTwtyGUjdmC6EHNnVewweWo7FjREBR8KfU/SbwElkaBCeGzgGcfUqxl8tYt48rOt9+CyFY8xwETw+xSr8hMte1rbPcuV2zmQQPveSL67rmHgCHml7XahkRW65f1DOUxsJhL4n7xdSxBKplAaAvSdu8OkgGs0a5+CDfdSSZ/BzMgMfLA4Q/qACjDVbHIqLrvkPwgUgdJce04GTLCUSVrpEov2Apx5EkmW/176W6bMSy48gtwUzWRkc8efwBUaiicvYLnWva8RMHGrQMcBmHgoj8H23wJ2JjjMv9M1qB8yxgZFLNBaT5iLs8icZeozfMIBoovImcluqQu+qvZBH3Orj46o6KGsZwi0gpGm9ztFA8ExfzhWffZKvPjFcsqF9jVgZO44hi+/mG6MzMV67Q0d0Jhj7fdHkMLVnGeLwuo4QQyehiDBITo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(316002)(8676002)(31686004)(8936002)(6666004)(186003)(66476007)(478600001)(86362001)(110136005)(38100700002)(966005)(66946007)(83380400001)(2906002)(36756003)(31696002)(6486002)(5660300002)(53546011)(66574015)(2616005)(16526019)(66556008)(45080400002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGhYZGxFMXkwb2lQK29mOU1Wbnh1M3YwRWptdzdFUlFjeTFmUFdkd1dzZlNJ?=
 =?utf-8?B?ai9PM3dhaWpnUXNFQ211Q2FFOFZCRDVjK1RobWlWODNjNUUwUU10eWY2RlNW?=
 =?utf-8?B?R3cvdEFINERsNkM3SWNBRDB2TGJjcWxuSlRoTlYxamlNU3hOOWhWVkdsb1JT?=
 =?utf-8?B?WDVYby9qTm8wTEdpUURmZDdLL1IrR3UyelpuemZGMUhsQWc0WWtRS0VwVGhM?=
 =?utf-8?B?M0dEdlRVZk5lTTFmc1NFZ0ZCZFNwTTZlR1RZdXFFcUNNdUR0NVRQNzFGSVUw?=
 =?utf-8?B?MWNXb2s4MGxjblloUEJyUjRUVFlLNDlwSm9WcHUvVm1adFE2QmRhZGhXZFhr?=
 =?utf-8?B?Q3Q5aVpDNEhhc2NvOElSbC95eHYzWHBxWGxxNGo2RmRGVXJQbnQ2MUtpamU4?=
 =?utf-8?B?b0VQYW9jcG0zUWttWHM5NmJZemFmSVg2MkZES2hjdldnTmdmUThsb0gyTmRv?=
 =?utf-8?B?MHJlSmI0QndtS3lzOTAyOUNyR29LQ2EybEtqTC9IME1PbHJZbUJvemlGaGE4?=
 =?utf-8?B?MTlFM0ExRkF5RW5uNExhTDV3bXBFcGhHT242WUtYS2g2a055a2NQY3R2Tk8x?=
 =?utf-8?B?YUVxOWhuNXI2bmZ4VkVPaEQ2MGRZaVNpR1kweTJqc21WNzJuVXlEMWRBMmxM?=
 =?utf-8?B?MHhnREhMMzN3S21DM3VlYnkrMjdSTXpvMG1CTzhucVRsd3UyRjFodmZLMUEr?=
 =?utf-8?B?M3JORnBmaVhMQnVyT2lZRllpQnVoNkwvdExiMUdiRCttalBVZEo3NGY2VG1J?=
 =?utf-8?B?SlF2bEVRMGM5MHlDRGd3OWhqSDU4QzhDV3REWURMZ3IxQnQ5ZXMrd202QWRh?=
 =?utf-8?B?WE9oSmJjNzhON0RuRmNwOGQ4Uk5PZ0ZLeGJhSmJxZUtOeXdybVhKYVZQbnUr?=
 =?utf-8?B?cnhkVi9ESkRUZnNFa1Btem5BL3RDeVFnY2Yxb1RXaDBEa2h0eDQybFNxbEh3?=
 =?utf-8?B?WjZXMnZFeFhiNkxiTmREK2FFcnlQSG5hMUVLN3I5WkZkQ2ZaSVFaUkcrbUJN?=
 =?utf-8?B?WWhBdkhQWER2bTA5TmE3ZEgySzVacDMzL3Z4dWZiTkdEV2Q1ZC9CYWdRZ0dy?=
 =?utf-8?B?NFpqR1FJMXI5RFhZMTZnR0ZYTEJyYXQvei9NQUJFemw5eWRUbTB1dmg4dW5q?=
 =?utf-8?B?UStaQUpjbStMbEJ1aU9ZczFGREVUZHcwV3dkZjJ3bkRPcUFRV2dXUDA2N28v?=
 =?utf-8?B?YnZtY01EZTBKN3BWS0FHUGVnakYrVHpXVUg2WVZaNVY3MEFzaDBXNjVqZGp3?=
 =?utf-8?B?emtEZ1d6MjBYQWJ5Z25EVjNCUHk0U1ZCWE0xTDNaQk1VcEFqNUJaVHZIeGZU?=
 =?utf-8?B?TVdKcFpmbXNGU2oxdjV0Z291cHlqSHczeGMzNVZzYTdkaDMybGdRZmFVZXd0?=
 =?utf-8?B?eUFQSkNHSVpnL0RpY2FNM2FOazYyanV6MytFZVNIZCtOVWk0cG4xQVVOQ3Fn?=
 =?utf-8?B?UVFjUmUzYkJDREJyK015VndYYW5ZVG83a0NVQ082Ui9qcnh5SVp3dkhyeFRH?=
 =?utf-8?B?bFA4SU80Qm8xajZuaTF4R2lPUEZ1MHF4dk40RmJaT0NmMTFDMExpOGgreXdQ?=
 =?utf-8?B?bCtSVlNlVU92N0tER2dMVHBuUUhRZS84SHNEekFJeTBHZkdJRW1qTXpQVUV4?=
 =?utf-8?B?Yjg3RUNsN3p1UzZWZExTWUFMcHJtMFU4Y1UyU1V2NFpPdXptOG93V3RiUVRn?=
 =?utf-8?B?eVRHMDBvMlJYSnNQMnNWUUtCUmRmOTdva3FjR3oxeDZBYStTVHY5L1llMmtJ?=
 =?utf-8?B?V0RGd2pId1VEWXlNTzloVVo0TXhseVdOZE5KNVFTd000dmdwcGpJN1YxZmFJ?=
 =?utf-8?B?VU5naTlNMFgySXF1ZUovbHpkT1VkVHZ0U3NjTW5oZ3cxRTkwYjJNRXlOZ04z?=
 =?utf-8?Q?TbISUyoucTrvR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f703bfe9-661e-47cc-56bf-08d9242bf0dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 12:02:19.4516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jlcmo23Jx0oqHssrXaoX9N1eZ4UlcETqjk0HHOp1dxGOwXNY9c7/BIZdw4++05au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDUuMjEgdW0gMTM6MTkgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+
Cj4gT24gNS8zMS8yMSAxMjo1NiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMzEu
MDUuMjEgdW0gMTI6NDYgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+Pj4KPj4+
IE9uIDUvMzEvMjEgMTI6MzIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMzEu
MDUuMjEgdW0gMTE6NTIgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+Pj4+PiBI
aSwgTGFuZywKPj4+Pj4KPj4+Pj4gT24gNS8zMS8yMSAxMDoxOSBBTSwgWXUsIExhbmcgd3JvdGU6
Cj4+Pj4+PiBbUHVibGljXQo+Pj4+Pj4KPj4+Pj4+PiBIaSwKPj4+Pj4+PiBPbiA1LzI3LzIxIDM6
MzAgQU0sIExhbmcgWXUgd3JvdGU6Cj4+Pj4+Pj4+IE1ha2UgVFRNX1BMX0ZMQUdfKiBzdGFydCBm
cm9tIHplcm8gYW5kIGFkZAo+Pj4+Pj4+PiBUVE1fUExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3Ig
dGVtcG9yYXJ5Cj4+Pj4+Pj4+IEdUVCBhbGxvY2F0aW9uIHVzZS4KPj4+Pj4+PiBHVFQgaXMgYSBk
cml2ZXIgcHJpdmF0ZSBhY3JvbnltLCByaWdodD8gQW5kIGl0IGRvZXNuJ3QgbG9vayBsaWtlCj4+
Pj4+Pj4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIHdpbGwgYmUgdXNlZCBpbiBjb3JlIFRUTSwgc28g
c2hvdWxkIHdlIAo+Pj4+Pj4+IGluc3RlYWQgc2V0Cj4+Pj4+Pj4gYXNpZGUgYSBtYXNrIGluIHRo
ZSBQTCBmbGFnIGZvciBkcml2ZXItcHJpdmF0ZSB1c2U/Cj4+Pj4+PiBIaSBUaG9tYXMsCj4+Pj4+
Pgo+Pj4+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBhZHZpY2UsIEdUVCBtZWFucyBH
cmFwaGljcyAKPj4+Pj4+IFRyYW5zbGF0aW9uIFRhYmxlIGhlcmUsIHNlZW1zCj4+Pj4+PiBhIGdl
bmVyYWwgYWNyb255bS4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIG1heSBhbHNvIGJlIHVzZWQgYnkg
Cj4+Pj4+PiBvdGhlciBkcml2ZXMuCj4+Pj4+PiBJIGhhdmUgbWFkZSBvdGhlciBwYXRjaGVzIGZv
ciB0aGlzLiBQbGVhc2UgaGVscCByZXZpZXcuCj4+Pj4+Pgo+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+
IExhbmcKPj4+Pj4+Cj4+Pj4+IE15IHBvaW50IHdhcyByZWFsbHkgdGhhdCB0aGUgZmxhZyBuYW1p
bmcgYW5kIGRvY3VtZW50YXRpb24gc2hvdWxkIAo+Pj4+PiByZWZsZWN0IHdoYXQgY29yZSB0dG0g
aXMgZG9pbmcgd2l0aCB0aGF0IGZsYWcuIElmIHRoZXJlIGlzIG5vIAo+Pj4+PiBzcGVjaWZpYyBj
b3JlIFRUTSB1c2FnZSwgSU1PIHdlIHNob3VsZCBtb3ZlIGl0IHRvIGEgZHJpdmVyIAo+Pj4+PiBz
cGVjaWZpYyBmbGFnIHRvIGF2b2lkIGZ1dHVyZSBjb25mdXNpb24uIEluIHBhcnRpY3VsYXIgYSB3
cml0ZXIgb2YgCj4+Pj4+IGEgZ2VuZXJpYyBUVE0gcmVzb3VyY2UgbWFuYWdlciBzaG91bGQgYmUg
YWJsZSB0byBrbm93IHdpdGhvdXQgCj4+Pj4+IGxvb2tpbmcgYXQgYW4gb2xkIGNvbW1pdCBtZXNz
YWdlIHdoYXQgdGhlIHBsYWNlbWVudCBmbGFnIGlzIAo+Pj4+PiBpbnRlbmRlZCBmb3IuCj4+Pj4+
Cj4+Pj4+IFNvIGhlcmUgd2UgYWRkIGEgZmxhZyB3aGVyZSBjb3JlIFRUTSBmb3JjZXMgYSBibyBt
b3ZlIG9uIHZhbGlkYXRlIAo+Pj4+PiBhbmQgdGhhdCdzIGl0LiBBbmQgdGhhdCBhcHBlYXJzIHRv
IGJlIGhvdyBpdCdzIHVzZWQgd2hlbiBhbiBhbWRncHUgCj4+Pj4+IGJvIGlzIGV2aWN0ZWQgdG8g
R1RULCAoYnR3IHNob3VsZCBpdCBiZSBhY2NvdW50ZWQgaW4gdGhpcyBzaXR1YXRpb24/KQo+Pj4+
Pgo+Pj4+PiBUaGUgb3RoZXIgdXNlIGlzIHRvIGZvcmNlIHRoZSBhbWRncHUgZHJpdmVyIHRvIHRl
bXBvcmFyaWx5IGFjY2VwdCAKPj4+Pj4gaXQgaW50byBHVFQgd2hlbiB0aGVyZSBpcyBhIGxhY2sg
b2Ygc3BhY2UsIGFuZCBJTUhPIHRoYXQncyBhIAo+Pj4+PiBkcml2ZXIgc3BlY2lmaWMgdXNlIGFu
ZCB3ZSBzaG91bGQgYWxsb2NhdGUgYSBtYXNrIGZvciBkcml2ZXIgCj4+Pj4+IHNwZWNpZmljIGZs
YWdzIGZvciB0aGF0Lgo+Pj4+Pgo+Pj4+PiBTbyBzaG91bGRuJ3QgdGhpcyBiZSB0d28gZmxhZ3Ms
IHJlYWxseT8KPj4+Pgo+Pj4+IFdlbGwgb25lIGZsYWcgbWFrZXMgc2Vuc2UgZm9yIHRoZSB1c2Ug
Y2FzZSBhdCBoYW5kIHRoYXQgZHJpdmVycyAKPj4+PiB3YW50IHRvIHNpZ25hbCB0byBUVE0gdGhh
dCBhbiBhbGxvY2F0aW9uIGlzIG9ubHkgdGVtcG9yYXJ5IGFuZCBub3QgCj4+Pj4gY29uc2lkZXJl
ZCB2YWxpZC4KPj4+Pgo+Pj4+IFRoYXQgd2UgdGhlbiB1c2UgdGhpcyBmbGFnIHRvIGltcGxlbWVu
dCB0ZW1wb3JhcnkgR1RUIGFsbG9jYXRpb25zIAo+Pj4+IHRvIGF2b2lkIHByb2JsZW1zIGR1cmlu
ZyBldmljdGlvbiBpcyBqdXN0IGV4dGVuZGluZyB0aGF0IHVzZSBjYXNlLgo+Pj4+Cj4+PiBPSywg
YnV0IGl0IGxvb2tlZCBsaWtlIHRoZXJlIHdlcmUgYWN0dWFsbHkgdHdvIHVzZS1jYXNlcy4gT25l
IGZvciAKPj4+IHBvc3NpYmx5IGxvbmctdGVybSBWUkFNIGV2aWN0aW9ucyB0byBHVFQsIHRoZSBv
dGhlciBmb3IgdGhlIAo+Pj4gdGVtcG9yYXJ5IHVzZS1jYXNlIHdoZXJlIHRoZSBob3AgcmVzb3Vy
Y2UgYWxsb2NhdGlvbnMgc29tZXRpbWVzIAo+Pj4gZmFpbGVkLiBPciBkaWQgSSBtaXN1bmRlcnN0
YW5kIHRoZSBjb2RlPwo+Pgo+PiBPayBzb3VuZHMgbGlrZSB3ZSBuZWVkIG1vcmUgZG9jdW1lbnRh
dGlvbiBoZXJlLiBUaGF0J3MgcmVhbGx5IG9uZSB1c2UgCj4+IGNhc2UuCj4+Cj4+IEtleSBwb2lu
dCBpcyB3ZSBuZWVkIHRlbXBvcmFyeSBhbGxvY2F0aW9uIGR1cmluZyBtdWx0aWhvcCB3aGljaCAK
Pj4gc2hvdWxkIGJlIGhhbmRsZWQgZGlmZmVyZW50bHkgdG8gbm9ybWFsIGFsbG9jYXRpb25zLgo+
Cj4gWWVzLCB0aGF0IHBhcnQgaXMgY2xlYXIgZnJvbSB0aGUgcGF0Y2hlcy4gVGhlIHBhcnQgdGhh
dCBJIGNhbid0IGZpdCAKPiBpbnRvIHRoYXQgcGF0dGVybiBpcyB3aHkgdGhlIGV2aWN0IGZsYWdz
IHdoZW4gZXZpY3RpbmcgZnJvbSB2aXNpYmxlIAo+IFZSQU0gdG8gR1RUIG9yIG9yZGluYXJ5IFZS
QU0gaXMgbWFya2VkIHdpdGggVFRNX1BMX0ZMQUdfVEVNUE9SQVJZLiAKPiBXb3VsZG4ndCB0aG9z
ZSByZW1haW4gZXZpY3RlZCBpbiB0aGF0IHBsYWNlbWVudCB1bnRpbCByZS12YWxpZGF0ZWQgdG8g
Cj4gdmlzaWJsZSBWUkFNIGF0IGFuIHVua25vd24gZnV0dXJlIHRpbWU/CgpOb3QgbmVjZXNzYXJp
bHkuCgpUaGUgc2l0dWF0aW9uIHdlIHJhbiBpbnRvIHdhcyB0aGUgZm9sbG93aW5nOgoxLiBPT00g
b24gVlJBTSwgd2UgdHJ5IHRvIGV2aWN0LgoKMi4gR1RUIHNwYWNlIGlzIHVzZWQgdXAgYXMgd2Vs
bCwgb2sgZXZpY3QgZGlyZWN0bHkgdG8gU1lTVEVNLgoKMy4gRm9yIFZSQU0tPlNZU1RFTSBldmlj
dGlvbiB3ZSB1c2UgYSB0ZW1wb3JhcnkgYm91bmNlIGJ1ZmZlci4KCjQuIFdhaXRpbmcgZm9yIHRo
ZSBib3VuY2UgYnVmZmVyIHRvIGJlY29tZSBpZGxlIGlzIGludGVycnVwdGVkIGJ5IGEgCnNpZ25h
bCBzbyBCTyBpcyBzdGlsbCBiYWNrZWQgYnkgYm91bmNlIGJ1ZmZlci4KCjUuIE5leHQgQ1MsIEJP
IGlzIHZhbGlkYXRlZCB3aXRoIFZSQU18R1RULiBUVE0gc2VlcyB0aGF0IGl0IGlzIGluIEdUVCAK
YW5kIGRvZXNuJ3QgbW92ZSB0aGUgYnVmZmVyLgoKNi4gQ1MgZ29lcyBpbnRvIG5pcnZhbmEgYmVj
YXVzZSBib3VuY2UgYnVmZmVycyBhcmUgbm90IG1lYW50IHRvIGJlIHVzZWQgCmZvciBDUyAod2Ug
Y2FuIGlnbm9yZSBhbGlnbm1lbnQgYW5kIGFjY291bnRpbmcgZm9yIHRoZW0pLgoKCj4KPiBQYXRj
aCAzLzM6Cj4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3BsYWNlbWVudF9m
cm9tX2RvbWFpbihhYm8sIEFNREdQVV9HRU1fRE9NQUlOX0dUVCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhYm8tPnBsYWNlbWVudHNbMF0uZmxhZ3MgfD0gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZ
OwoKVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCwgdGhpcyBpcyBpbmRlZWQgc3RpbGwgdGhl
IHdyb25nIHBsYWNlLiAKR29pbmcgdG8gZml4IHRoYXQuCgpDaHJpc3RpYW4uCgo+Cj4KPgo+Pgo+
PiBDaHJpc3RpYW4uCj4+Cj4+Pgo+Pj4gL1Rob21hcwo+Pj4KPj4+Cj4+Pj4gQ2hyaXN0aWFuLgo+
Pj4+Cj4+Pj4+Cj4+Pj4+IFRUTV9QTF9GTEFHX0ZPUkNFX01PVkUKPj4+Pj4KPj4+Pj4gYW5kCj4+
Pj4+Cj4+Pj4+IEFNREdQVV9QTF9GTEFHX1RFTVBPUkFSWQo+Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+
Pj4+Cj4+Pj4+IC9UaG9tYXMKPj4+Pj4KPj4+Pj4+PiBUaG9tYXMKPj4+Pj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+Pj4+Pj4+IEZyb206IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+
Cj4+Pj4+Pj4gU2VudDogVGh1cnNkYXksIE1heSAyNywgMjAyMSA5OjMxIEFNCj4+Pj4+Pj4gVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4+Pj4+Pj4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBIdWFuZywgUmF5Cj4+Pj4+Pj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyIAo+Pj4+Pj4+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsKPj4+Pj4+PiBZ
dSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPgo+Pj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRy
bS90dG06IGNsZWFudXAgYW5kIGFkZCBUVE1fUExfRkxBR19URU1QT1JBUlkKPj4+Pj4+Pgo+Pj4+
Pj4+IE1ha2UgVFRNX1BMX0ZMQUdfKiBzdGFydCBmcm9tIHplcm8gYW5kIGFkZCBUVE1fUExfRkxB
R19URU1QT1JBUlkgCj4+Pj4+Pj4gZmxhZwo+Pj4+Pj4+IGZvciB0ZW1wb3JhcnkgR1RUIGFsbG9j
YXRpb24gdXNlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8TGFuZy5Z
dUBhbWQuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+IGluY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2Vt
ZW50LmggfCA1ICsrKy0tCj4+Pj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90
dG0vdHRtX3BsYWNlbWVudC5oCj4+Pj4+Pj4gYi9pbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVu
dC5oIGluZGV4IAo+Pj4+Pj4+IGFhNmJhNGQwY2Y3OC4uOWY1Y2ZjN2MyZDVhIDEwMDY0NAo+Pj4+
Pj4+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmgKPj4+Pj4+PiArKysgYi9p
bmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oCj4+Pj4+Pj4gQEAgLTQ3LDggKzQ3LDkgQEAK
Pj4+Pj4+PiDCoCAqIHRvcCBvZiB0aGUgbWVtb3J5IGFyZWEsIGluc3RlYWQgb2YgdGhlIGJvdHRv
bS4KPj4+Pj4+PiDCoCAqLwo+Pj4+Pj4+Cj4+Pj4+Pj4gLSNkZWZpbmUgVFRNX1BMX0ZMQUdfQ09O
VElHVU9VU8KgICgxIDw8IDE5KQo+Pj4+Pj4+IC0jZGVmaW5lIFRUTV9QTF9GTEFHX1RPUERPV07C
oMKgwqDCoCAoMSA8PCAyMikKPj4+Pj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19DT05USUdVT1VT
wqAgKDEgPDwgMCkKPj4+Pj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19UT1BET1dOwqDCoMKgwqAg
KDEgPDwgMSkKPj4+Pj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19URU1QT1JBUlnCoMKgICgxIDw8
IDIpCj4+Pj4+Pj4KPj4+Pj4+PiAvKioKPj4+Pj4+PiDCoCAqIHN0cnVjdCB0dG1fcGxhY2UKPj4+
Pj4+PiAtLSAKPj4+Pj4+PiAyLjI1LjEKPj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+Pj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdD
Y2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0MxMjQ4MjNmNThlZTc0MTY4NGQ2YTA4ZDkyNDI2
MDU2NyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1ODA1
NjgwMDkxMTc5NzYlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlM
Q0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7
c2RhdGE9ZDhrMGM4U0FjR0dwMW00bUVtQThuRHJNJTJGSDZiNU13bzl1JTJCelI5aml3M0ElM0Qm
YW1wO3Jlc2VydmVkPTAgCj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
