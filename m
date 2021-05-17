Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF14C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064A361007
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064A361007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7986E207;
	Mon, 17 May 2021 07:26:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82F46E207
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 07:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaXztLM3kJKyGmFiES5yx8uXRhuq1LjDn7ZojzOEAZwmk/Ab6FndseS1v9nhZ1xmr+26ZEAFX7aLgls1/6koJhFXfOYLK3+UMkLgKpj4J8/VccinD3LFGx0IGpeDUIT4E4tZzDwYmiRiI1qYDYSfqBT+u6TlMFm/noa114txIFbh3/0O/aKhX6JfoQ7asL+uFhvnbr7rnDYh/C7YysXdfu+o9EIb3TO8akbDVLw2SwOfvtulJFMvLxOG2XB/ppi3B5RXgSYOF5+FTR1MRaQiVVpLYxibcNFYHdk//ni1jNj/OjiZv+ueRkkpIPzklYVIVgkclpt5FtVZVMUXRJ++aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwmCglCzhbFqgKLIe0mm2OqCeJBbWQXMzhkAagbxH3c=;
 b=Wd406O2F51rXw3xKFDqz6XZV+U5RjLMV+7TGq25bVDh9ttjntwa0IJx4XRIxZp2Mz6g7ix/O1rRRSHuzF8JhS7HGsh4RrfsnkPIR3rZFGYveBCZbGAPwlDUczSljcpKFvosqp6/V6JyBMlIAkDKSlzZTp4GtFhFaGX6n6JtMcvya/pa7rT/SuRTZLFJKZ8UuWOSP6O2MzucRryzOc+5nZ1EpRPzU3aFpPwevU8Yg3dFQxUYbKROJ2vkd4B9yyhnRUcW2ytJ7WMI9opaQehAq1Gjlc+iCoC31EFTZ9ZbRzrDlee0xa4PKXOOt609mtvGVaMFNgCPwAhIFsktRQiBSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwmCglCzhbFqgKLIe0mm2OqCeJBbWQXMzhkAagbxH3c=;
 b=0QJKpQ3daOmesYfOdo0bcvHi13FX3NR9uA0BiOz7tPxGB0bcbeoAzZh2YDV5m7SLG6PrsbkfjP1s6o7O4xar27Qb9C29wmPu4KZHJdUv71NG/Y9Mk8z0BnQoDpbHAnevOpZE/3V1dR0PYDekxDGjlnePOhaKhFjSp578KYrSExA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4638.namprd12.prod.outlook.com (2603:10b6:208:ff::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:26:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:26:55 +0000
Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210517043940.99603-1-Jiansong.Chen@amd.com>
 <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
 <BY5PR12MB48858069A0EBCDBED03B6052EA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <492b38eb-bf99-bdd1-b874-c95905b79a5f@gmail.com>
 <BY5PR12MB488585C22712D75B9B36E50BEA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4fb78299-e482-ac38-1b49-609882b26cd2@amd.com>
Date: Mon, 17 May 2021 09:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BY5PR12MB488585C22712D75B9B36E50BEA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6bbe:b48c:2de1:422d]
X-ClientProxiedBy: PR3P189CA0089.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d]
 (2a02:908:1252:fb60:6bbe:b48c:2de1:422d) by
 PR3P189CA0089.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.32 via Frontend Transport; Mon, 17 May 2021 07:26:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 800ecf58-c188-4145-f0b5-08d919052642
X-MS-TrafficTypeDiagnostic: MN2PR12MB4638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4638D3F7A4881CEF5CA56A1A832D9@MN2PR12MB4638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUNYFuwHM4GPBhxcWmhB9x+Jvt1nPv7eKczYJ+hTP03iN1t2Jy8ozpVZ4Q28//klGtPJozyV485Ft7cYLfrnvHrJ08duN/UwAzTxkl1+XgfDnrSinzeOkm7SBio1H+AScs8r3+o9mW0oy2ADIZMYEl5DX6W3Mi5HqcAuK7wpqzwtVATaIddekR+fhUQ1HutwT/l4abdhlmIHZuvUO+fKtkg3KLPe1R/2B3WRFrXao5eV+Rm/WRC7FEMRsS4jjARDy5c+jzLk5Jb66n2wnIAxQzjPygaEFoFTNNl9Y24kTPGNwfxQh+kgLVUhsbi57we+IyLZZxnDkSIfMCIwD+fgL3p9xa5UoAy02mlLCdJAHXX14W+nM8mD/ohEaO9HvuoExVAscrieuPBTQ9k4WFkskFsT/c+1tDL3CFR7x/t0cTMtHk8qwW/kODUnb4JR8jrklcFEqCXcvCPF3sMz4/frzk+lTaS+mFuXkaZ8Xm4dBc8EElEC0jXx7APQWzOv1uvKG52UZjdyGWBTy36K6pNV/m/pHBvBzy/tRTIjXtKTmrRm6yQirLWHHRvdkOvdhhx3yO/Z1V6qhdwZpZTiQviUH85qd2fVgQolWTPdCg1rxUaCWQAkSoqJeM0uqxhvcJqbkfevIKJzefYFkm3NIuXU2xWzx0PVWdZTHQPFHlLLOfY/fTgBLNKdXK45JHfltIM0jxBFBtTEDzhzyQCtSzcyP4vAA/pMhO3dwusiMmSXRU+LdRpRc3mugb3egGKl6dTMA+2aQAStr2T7qJYovkTjqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(52116002)(66946007)(2906002)(66556008)(66476007)(186003)(966005)(2616005)(45080400002)(53546011)(6486002)(316002)(5660300002)(16526019)(110136005)(83380400001)(31696002)(31686004)(66574015)(86362001)(6666004)(8676002)(8936002)(38100700002)(36756003)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YnVmR3NvcTR6elJDR1ovU2NYaVozaVlJamhTT2JWNVVDRy9qd1ZjZFc1QjNz?=
 =?utf-8?B?RjlOeHZnSGhKWnB2eGNSWXF5cmFVS2hyc25GRlBEUG5SWHgvQVh5YUZvSWZD?=
 =?utf-8?B?M2hIbVh0NUExNTVRTzYvUEJYNG1uZDdWUGNjVFkxSjR0bUxmYjlHYXZVUHBq?=
 =?utf-8?B?ZVg2YmxaMkN4Vm4zbWFOa2hPZE9ZazlQQjVhNVd4UDBQYjRlb1BybnJsMzdU?=
 =?utf-8?B?K0hySkdDZW9Qb3hBMmxGUkVPSFZMNnhhVXFMYzRhVWhLWGhzZEtlQjZydTlo?=
 =?utf-8?B?VkQyRlNZZlhRcmw2dnBEYk9HZDRPWGFVUjFaZkxsZGRIeEFCcHprSUdxa2Zo?=
 =?utf-8?B?UnM4dk1JWHhYZW00NUJUOHhzSHZnMDRSM0U5a3poMHM4ell0eVZsZlROek9i?=
 =?utf-8?B?LzAyUVNxeEd3dmtsNkhvRGFFbzVyYUdkTkNFbS8yTFkwblpjelFLQUt3S0hk?=
 =?utf-8?B?YXNIK0FvdEYzVzE3ZDNvaDFUOWMra2NRakltQllERTZIRyttTExtUFJCaFBs?=
 =?utf-8?B?SUVnT2dDTE1JVlc5dzZLVXVvdFYydG5HTXozUjBpTS9qelBVbmxIc2orTEJa?=
 =?utf-8?B?SVVyc1JyK3VPQmhWOWJpSklDVDdVZnJMS2Y1NFdZTEtGWnppdTFYVXhHNkNx?=
 =?utf-8?B?dGxOMTR6RmI3UlFxRUlWWmJwVDRLOG12aFp2K3QzbDlIK2JzNjFENnNkbmNt?=
 =?utf-8?B?K1laZW41OGVkODBaY0FUbVpGU0tFM05TbDRtMDV1YUl6Ylk2Zld3VElzcllN?=
 =?utf-8?B?S0JmUzluY2ZiTjhlZFF1Q09la0FobUxGaHZaS1ZBdjFqTXlTSnk2b2o1MEwz?=
 =?utf-8?B?bHl2VEVhbCtndVBDOVlHMWt2OUl3TXNnOHJscjg2T0E1dTBrVEtzVUFNcUVu?=
 =?utf-8?B?QmJhMEdVQ1IyZmh6aDRQMHhXaGIySDZ4Q2tHVjBVTEJUbStLcWpmTDZSTU8x?=
 =?utf-8?B?dWtwaE9LN1RYa3Z1R3ZJZWRBek9CZkFWb0MzZGo3U1JzVzZmc25WZW5WWHMv?=
 =?utf-8?B?bzVwdG1VZ203Q1hKak5DRjJxWWtTeGRkdGI4dEVhM3lUL2dOZ0dQc0RYTnpt?=
 =?utf-8?B?R3FtblEvSWpQV1hYb0VuczFJNkt5MTFENDF2YmFmbng2OFZLVFNEakhKdFdL?=
 =?utf-8?B?eHRvMnJRUDFVcjhEMldURysxYjRBZFl1bHZNbFVNcnlXMUhHRXp3bEJnMnV1?=
 =?utf-8?B?NjU3ZDVTaDVhdktNcDlVWDNvL3hLankvRWRDejcxMUZaNDZuRk95V2JkZVND?=
 =?utf-8?B?d21RcFFwSEtsZlArZXQvUzRTemVhMkhPNndjYVc2em1YYUJjaTZSa2IwWWo5?=
 =?utf-8?B?L1U3cmx1S3pKNFFlSW4xQmNpTjROQXh5NFgwZjVaeSt2UXdtQkp0RllTNjNQ?=
 =?utf-8?B?QzUzaTlJKzRCcjlMRnFEQUlNSDEzNGxFSERnNVZhWFo1TVRuZkI1ZnREQ0FH?=
 =?utf-8?B?cFo0cm92WGVzb1I0VUdrNVkyc216MUxFVWFjZHVuUjJJZHdvdjZyZTBUdmdj?=
 =?utf-8?B?Y0o4Y21rY1E5SXhOUHVzUWdmeVplUDhOMUV3L3pTMTVuRHF4clhZKzRUWWtJ?=
 =?utf-8?B?djJUbUhzaHFoMlZGbzNoNVhKK3cxSmlGL1owZjd4WUpRUkxtMmQ4czY2T1hJ?=
 =?utf-8?B?b29NM3JGUnFkRXdIaVFYWWZUZGU5c3BTRVZpOVVJQkZXVFFicmFkck9DR1ZX?=
 =?utf-8?B?UFlmTko3L0NrdWRVWnduanBwRXBMUkc4RDdMTnFHbHcrOTYyRytuS3dhcFI5?=
 =?utf-8?B?UjZ4OHBOS3o3a25qVXFYeTdoQklrUG9jT0I2c3lPSElRamRaTm55WnZLVmpr?=
 =?utf-8?B?RGhEN0gvWTQ3cnI3UkZLcmNkREdPcGVqRGYvUlI5TWJlMWx5SmR5MXhwY3lW?=
 =?utf-8?Q?NqBjCbR1+CsAu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800ecf58-c188-4145-f0b5-08d919052642
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:26:55.8697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imf9WkS3phNvDylb100kwz2kpRWBA8BcKtDEfIkSdoWp59h77hhxi+n3RHcFcsz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4638
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

WWVzIGFuZCBleGFjdGx5IHRoYXQgaXMgdGhlIHRvdGFsIG1lc3MgSSB3YXMgdGFsa2luZyBhYm91
dCA6KQoKVGhlIGJhY2tlbmQgc2hvdWxkIGJlIGdpdmVuIGNsZWFyIG9yZGVycyB3aGljaCBpdCBh
Y3Qgb24uIEluIG90aGVyIHdvcmRzIAoibG9hZF9nbG9iYWxfKiIsICJsb2FkX2NlX3JhbSIgZXRj
Li4uCgpUaGUgbWlkZGxlIGxheWVyIGluIGFtZGdwdV9pYl9zY2hlZHVsZSgpwqAgdGhlbiBkZWNp
ZGVzIGJhc2VkIG9mIHRoZSAKZmxhZ3MgaWYgdGhlIHdoYXQgb3JkZXJzIHRoZSBiYWNrZW5kIHNo
b3VsZCBleGVjdXRlLgoKSWYgeW91IHdhbnQgdG8gZG8gdGhpcyByaWdodCBJIHdvdWxkIHN1Z2dl
c3QgdGhhdCB5b3UgY2xlYW4gaXQgdXAgCnRob3VnaHRmdWxseS4KCklmIHlvdSB3YW50IHRvIGp1
c3QgZ2V0IGl0IHdvcmtpbmcgZm9yIG5vdyBJIHN1Z2dlc3QgdG8gYWRqdXN0IHRoZSAKc2tpcF9w
cmVhbWJsZSB2YXJpYWJsZSBpbiBhbWRncHVfaWJfc2NoZWR1bGUoKSBhbmQgbWFrZSBzdXJlIHRo
YXQgd2UgCm5ldmVyIHNraXAgYSBwcmVhbWJsZSB3aGVuIGdmeG9mZiBpcyBlbmFibGVkLgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKQW0gMTcuMDUuMjEgdW0gMDk6MjAgc2NocmllYiBDaGVuLCBKaWFu
c29uZyAoU2ltb24pOgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldCj4KPiBEb2VzJ3QgdGhlIGJl
bG93IGNvZGUgaW4gZ2Z4X3Y4X3JpbmdfZW1pdF9jbnR4Y250bCBkbyBhbG1vc3QgdGhlIHNhbWUg
dGhpbmcgYXMgZHJvcHBpbmcgdGhlIHByZWFtYmxlIGliLiBJIGNhbm5vdCB1bmRlcnN0YW5kIHdo
eSBib3RoZXIgdG8gZHVwbGljYXRlIHRoZSBvcHRpbWl6YXRpb24gYW5kIGNhdXNlIGEgbWVzcwo+
IEluIHRoZSBjb21tb24gY29kZS4KPiAgICAgICAgICAgICAgICAgIC8qIHNldCBsb2FkX2NlX3Jh
bSBpZiBwcmVhbWJsZSBwcmVzZW50ZWQgKi8KPiAgICAgICAgICAgICAgICAgIGlmIChBTURHUFVf
UFJFQU1CTEVfSUJfUFJFU0VOVCAmIGZsYWdzKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBk
dzIgfD0gMHgxMDAwMDAwMDsKPiAgICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICAg
Lyogc3RpbGwgbG9hZF9jZV9yYW0gaWYgdGhpcyBpcyB0aGUgZmlyc3QgdGltZSBwcmVhbWJsZSBw
cmVzZW50ZWQKPiAgICAgICAgICAgICAgICAgICAqIGFsdGhvdWdoIHRoZXJlIGlzIG5vIGNvbnRl
eHQgc3dpdGNoIGhhcHBlbnMuCj4gICAgICAgICAgICAgICAgICAgKi8KPiAgICAgICAgICAgICAg
ICAgIGlmIChBTURHUFVfUFJFQU1CTEVfSUJfUFJFU0VOVF9GSVJTVCAmIGZsYWdzKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBkdzIgfD0gMHgxMDAwMDAwMDsKPiAgICAgICAgICB9Cj4KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+IFNlbnQ6IE1vbmRheSwgTWF5IDE3LCAyMDIx
IDI6NTYgUE0KPiBUbzogQ2hlbiwgSmlhbnNvbmcgKFNpbW9uKSA8SmlhbnNvbmcuQ2hlbkBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogb3B0aW1pemUgdG8gZHJvcCBwcmVhbWJsZSBJQiBmb3Igb2xkIEdQVXMKPgo+IEFtIDE3LjA1
LjIxIHVtIDA4OjUxIHNjaHJpZWIgQ2hlbiwgSmlhbnNvbmcgKFNpbW9uKToKPj4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seV0KPj4KPj4gRG9lc24ndCAgY3VycmVudCBzb2x1dGlvbiBhbHdheXMgZW5h
YmxlIHRoZSBvcHRpbWl6YXRpb24gaW4gYSBzYWZlIGFuZCBtb3JlIGNsZWFyIHdheT8KPiBObywg
d2UgYWxzbyBuZWVkIHRoaXMgZm9yIGdmeDggd2hlcmUgZ2Z4b2ZmIGlzIGN1cnJlbnRseSBub3Qg
aW1wbGVtZW50ZWQuCj4KPiBBZGRpdGlvbmFsIHRvIHRoYXQgd2UgbWl4IGNvbW1vbiBmcm9udGVu
ZCBoYW5kbGluZyBpbnRvIHRoZSBiYWNrZW5kIHdpdGggdGhpcyBhcHByb2FjaC4KPgo+IEJ1dCB5
b3UgY291bGQgY2xlYW4gdXAgdGhlIGNvZGUgaW4gYW1kZ3B1X2liX3NjaGVkdWxlKCkgcXVpdGUg
YSBiaXQuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+PiAxLiBmb3IgZ2Z4OC85LzEwIHdl
IHVzZSBsb2FkX2NlX3JhbSBpbiBjb250ZXh0X2NvbnRyb2wgdG8gY29udHJvbCB0aGUgb3B0aW1p
emF0aW9uLgo+PiAyLiBmb3IgZ2Z4Ni83LCB3ZSBkaXJlY3RseSBkcm9wIHRoZSBwcmVhbWJsZSBp
Yi4KPj4KPj4gUmVnYXJkcywKPj4gSmlhbnNvbmcKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4K
Pj4gU2VudDogTW9uZGF5LCBNYXkgMTcsIDIwMjEgMjo0MiBQTQo+PiBUbzogQ2hlbiwgSmlhbnNv
bmcgKFNpbW9uKSA8SmlhbnNvbmcuQ2hlbkBhbWQuY29tPjsKPj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogb3B0aW1pemUg
dG8gZHJvcCBwcmVhbWJsZSBJQiBmb3Igb2xkCj4+IEdQVXMKPj4KPj4gV2VsbCBOQUssIGFzIGRp
c2N1c3NlZCBjaGVja2luZyB0aGUgZ2xvYmFsIGZsYWcgaXMgbW9yZSBmbGV4aWJsZSBzaW5jZSBp
dCB3aWxsIHN0aWxsIGVuYWJsZSB0aGUgcHJlYW1ibGUgZHJvcCB3aGVuIGdmeG9mZiBpcyBkaXNh
YmxlZC4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+PiBBbSAxNy4wNS4yMSB1bSAwNjozOSBzY2hyaWVi
IEppYW5zb25nIENoZW46Cj4+PiBUaGUgb3B0aW1pemF0aW9uIGlzIHNhZmUgZm9yIG9sZCBHUFVz
IGFuZCBjYW4gaGVscCBwZXJmb3JtYW5jZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKaWFuc29u
ZyBDaGVuIDxKaWFuc29uZy5DaGVuQGFtZC5jb20+Cj4+PiBDaGFuZ2UtSWQ6IElkM2IxMjUwZjFm
ZTQ2ZGRkYmU4NDk4ODk0ZmI5N2U5NzUzYjdjYWZlCj4+PiAtLS0KPj4+ICAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jIHwgNiArKysrKysKPj4+ICAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jIHwgNiArKysrKysKPj4+ICAgICAyIGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjZfMC5jCj4+PiBpbmRleCAzYThkNTJhNTQ4NzMuLmM5MTVjYzQzOTQ4NCAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMKPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMKPj4+IEBAIC0xODczLDYgKzE4
NzMsMTIgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y2XzBfcmluZ19lbWl0X2liKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZywKPj4+ICAgICAgICAgICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAw
KTsKPj4+ICAgICAgICAgfQo+Pj4KPj4+ICsgICAgIC8qIGRyb3AgdGhlIENFIHByZWFtYmxlIElC
IGZvciB0aGUgc2FtZSBjb250ZXh0ICovCj4+PiArICAgICBpZiAoKGliLT5mbGFncyAmIEFNREdQ
VV9JQl9GTEFHX1BSRUFNQkxFKSAmJgo+Pj4gKyAgICAgICAgICEoZmxhZ3MgJiBBTURHUFVfSEFW
RV9DVFhfU1dJVENIKSAmJgo+Pj4gKyAgICAgICAgICEoZmxhZ3MgJiBBTURHUFVfUFJFQU1CTEVf
SUJfUFJFU0VOVF9GSVJTVCkpCj4+PiArICAgICAgICAgICAgIHJldHVybjsKPj4+ICsKPj4+ICAg
ICAgICAgaWYgKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKQo+Pj4gICAgICAgICAgICAg
ICAgIGhlYWRlciA9IFBBQ0tFVDMoUEFDS0VUM19JTkRJUkVDVF9CVUZGRVJfQ09OU1QsIDIpOwo+
Pj4gICAgICAgICBlbHNlCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y3XzAuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5j
Cj4+PiBpbmRleCBjMzVmZGQyZWYyZDQuLjZkOWNjYWU0ODAyNCAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMKPj4+IEBAIC0yMjY5LDYgKzIyNjksMTIgQEAgc3Rh
dGljIHZvaWQgZ2Z4X3Y3XzBfcmluZ19lbWl0X2liX2dmeChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcsCj4+PiAgICAgICAgICAgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMCk7Cj4+PiAg
ICAgICAgIH0KPj4+Cj4+PiArICAgICAvKiBkcm9wIHRoZSBDRSBwcmVhbWJsZSBJQiBmb3IgdGhl
IHNhbWUgY29udGV4dCAqLwo+Pj4gKyAgICAgaWYgKChpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxB
R19QUkVBTUJMRSkgJiYKPj4+ICsgICAgICAgICAhKGZsYWdzICYgQU1ER1BVX0hBVkVfQ1RYX1NX
SVRDSCkgJiYKPj4+ICsgICAgICAgICAhKGZsYWdzICYgQU1ER1BVX1BSRUFNQkxFX0lCX1BSRVNF
TlRfRklSU1QpKQo+Pj4gKyAgICAgICAgICAgICByZXR1cm47Cj4+PiArCj4+PiAgICAgICAgIGlm
IChpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkKPj4+ICAgICAgICAgICAgICAgICBoZWFk
ZXIgPSBQQUNLRVQzKFBBQ0tFVDNfSU5ESVJFQ1RfQlVGRkVSX0NPTlNULCAyKTsKPj4+ICAgICAg
ICAgZWxzZQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0Cj4+IHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDSmkKPj4gYW5zb25nLkNoZW4lNDBhbWQu
Y29tJTdDZjgwZjdkOTg4OGY0NDI3YzJiMTQwOGQ5MTkwMGUzMzUlN0MzZGQ4OTYxZmU0OAo+PiA4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU2ODMxMzg2OTA5NTEzMSU3Q1Vua25v
d24lN0NUV0ZwYkdaCj4+IHNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTMKPj4gRCU3QzEwMDAmYW1wO3NkYXRhPU1GMSUy
Qmhha0hwQjhOOUI4SndYQ0E5eUIxaEl5NENOTk1vazZBU3ozQU9VMCUzRCZhbQo+PiBwO3Jlc2Vy
dmVkPTAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
