Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EEDC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 16:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2A664F03
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 16:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2A664F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9C06ECDD;
	Thu, 25 Feb 2021 16:48:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85676ECDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 16:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2cRvGB9IyDIF9TMP8lgUKT99D3lYsDUTkwfO2F1qxDuUJ1KNJoyRoAve0WHWo2CtoNSfMQsjEzc1clX46eiBgOzvLIQ7yloxYjoPgf9x23hFLKHZxklHW8rxEK2V3gEeFHzsMASgUnbmMXr09nrCAEpfEkpziWmKa2XRRumJMXIlRORgttzAyJXPVB9Fnt2hD5M0aV4b9CudRNEKJgroE5Re8qNHzsM+CFBWhLoeSXJmdak/rnuk5Cn/RFe1EmODMrglZl38aHgHjkBNLmhUen4UW+7UPIZCLf2vUal9vvnKCXkxQQ1nGW2adLvA3s0GkM5g6mQe4/S5cgDpTNaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyBMazAHXTTbNLZMFW2i89nyhWIBVXc+oWsCyM6hdNE=;
 b=i1LgfVG39a80IRrpE1T+/yfk735W04Kas6GlGCSTwZ+6YQ++vyTJ2Pie+vc5ERw3iCr6L00O7Hb3fIFePUla86EXCYuNTuue7A/nUmjSLPr0fkc54kv4dnZ2OzVVQgsj2NkTbxHzKFkQhKvAk6YrB85yDNq4hLFip5lm+T1AW3Pm0522nmUPyuxA7H9PWK25kMdTiWOypo2NzyaU231dM4C7mXnuGOiI6+wVi+UfWPrHHXuOKTUEZAc8gp4X5oaIZCOTH2nCnGlIgAsn6DtIUQJKPEIpJK9BlrIpuT6WXbfPVDiBUzKpU5q2ubfSnEsJmINaw15mOSP6a0FDO3OKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyBMazAHXTTbNLZMFW2i89nyhWIBVXc+oWsCyM6hdNE=;
 b=2WPDLIBrH4jOSprrzE85nb80rdZ+iL6JQwYl0DtoZm1hbSPKOjXov0my/M/hpmefCKyXvsaVd3/Fjs2QcDJeDhJTxlDftG3DV6EAXwQuLnPkwVdPCnp+ZjDQRVxtpumGGjeZ2x9ChifpS4KOdjKsLAYKUXu3671Qy51yRMeXHeg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 16:48:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 16:48:14 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
 <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
 <00ce83e0-a000-913b-57a1-53c07fdfcdef@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <23f02e39-4ead-a20e-5c5c-749b00fd400f@amd.com>
Date: Thu, 25 Feb 2021 17:48:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <00ce83e0-a000-913b-57a1-53c07fdfcdef@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7944:296:6ad0:31ef]
X-ClientProxiedBy: AM0PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7944:296:6ad0:31ef]
 (2a02:908:1252:fb60:7944:296:6ad0:31ef) by
 AM0PR06CA0130.eurprd06.prod.outlook.com (2603:10a6:208:ab::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 16:48:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5821c687-9289-4510-3337-08d8d9ad245c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23872400534625B135073A3F839E9@BL0PR12MB2387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL7VQ+nMKvqNQIrseEyZb7wdyTgGcYQP1XUEQQbPs0N/VuuJscYQWNgkyQyRIP8D0lYonyWN8XivNjfJ3BpTIwUaHyP8tLNj8iis/3uPRTYrAZix52XLO8iej3LVRQbOdjLctTIlcUKDKHauk+l/qXrxlkwVilkVWrkHccsawI9xx946B4yUXvsKenT1X1EcwDrN8xTIOVT6zQmB8nXTJc9VHlHbvlY76mGone7lk6n+zZ0s6oDAmdNsQPl2vzuKTTA2uFUVWiHi4Wk9VYH9huotkdSLOBtCzUpeIcDqFWqUEZGQcHO7BIHxaWUf0fp0J28bWRPmxrSTzYo7XG6SWWOpY2Yr5v7FvnA0ELtJOy5iSQVwQjeyLGlLyO04r72W+Ml4lcHDtaY2+joDm1f7zkjkzTRZrsP8AMY5nLTDMABBbikCT9iOcOTFTrdJS/8U5KoZD0GAmJwRMGhqEZcjGeFKlggmts+X1zDPnm66/EYIZ+/zKLlbhzswybgD5QmhS2MBU1M4tm9yz7CQqCPmVjTD3AXsp/MvD7xtxItpcFb0tnImqwHUiVsuKFAn4UaMJV5e2CNAOVh2QJBxuaVX7zYULZ9oy9BXkAN/3KC0umF3dA4CXui0eD87RF3KHveumhJ/tYj1Vx0BPQCpPClTVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(478600001)(6486002)(316002)(110136005)(45080400002)(53546011)(66574015)(86362001)(36756003)(8936002)(66556008)(66476007)(31696002)(4326008)(8676002)(6666004)(186003)(52116002)(2616005)(31686004)(2906002)(66946007)(16526019)(83380400001)(966005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzdwa1JGeGY4YURHMDZmSGNWN0YzR0NxdFVHcUNqYVplSm9rUnFiZ1p2Qmx3?=
 =?utf-8?B?Y0ZpZVFXZHpYNzFaWmZmbWlwUEdrUWN5SXU0Z0l4cTZXb1VDOW1iN1gvV3d1?=
 =?utf-8?B?NlpucVl6dUdDQXdFZFdnbHN1eEdGTW41YnZCRGViSm9paVZKM0kwK3Jmcm5x?=
 =?utf-8?B?TWlBUU02aC9PODJvaklrZ0tiL0N1RXl0aUlBUWhPRWJDdTVHMmxNSlo0bjFl?=
 =?utf-8?B?dGg3VWR0UUZNYWJtZk9VZ01aZFcxMVovV05jbG4xdjlXeGFaUGR2ckIrNkV5?=
 =?utf-8?B?NkEwalByamlVZWNydzFzWGNxQWZDQUNaVFNvOEpCbjJkSDRVYkZLbXJHWGVH?=
 =?utf-8?B?ZjNXNFpHNDB6RHZaeW5kcnlITitMSFVadkN1ZWVBY2Q0d3ZzU1QyQTd0UDJj?=
 =?utf-8?B?VXRjNi81SG5PcjAwWk4yUTNhNlljMjBhSDlTZ3FTUHl6U05FY1IrNmZ0VHdp?=
 =?utf-8?B?NS9KOTVDQWtGZi9FcVR3ODdLRDFjKzMvRU95Sm5rZDJJY0g2UldKdmt3M2s0?=
 =?utf-8?B?L0Y0ZFZzc0NmUGJFT3pnNXBiUUUzTlpjdk9yWXl5N213SWVVWEh5bUl1eXN3?=
 =?utf-8?B?aktsNWVpajZaQ1FrVUsvbFdvd0MwRmZxa0phNFQ5WE84TnhLZkhMVlc3YTNS?=
 =?utf-8?B?RG1NS2w1S2U3cFFuOEJJMnNKcGZDRU9iNzFFcnVnOFY1WUdFMmRROGxJZERD?=
 =?utf-8?B?MTFJc3dyd1p5Yy91TEl6RXZQNGF5N0x3REdUY0s5eTNuUFIrOWNmSnpNRnhr?=
 =?utf-8?B?TkNPb2NZVG91Yk5iUEZNWitIVWZJTUcyVEFFbXNqVHNuZTIwMUdTVFYzT0tK?=
 =?utf-8?B?K3VzaUlDaGNUTTZSRzhuaC9reERrNWk3b3BRR3JmWmVYb0VBYUN0cmsvOHQ1?=
 =?utf-8?B?dzRNT0V5eGo2ekdjdGtaWXNoOXpnSzEzazR1ZFhUNDcrcXhJVmcxd2xtYXZs?=
 =?utf-8?B?SnUya3BsVUc1UmNhUFBmb3psN3FnZGRLUjhPRTBZcjBrTXd1M1hveGx1SVFs?=
 =?utf-8?B?K2JtMDRnYXBuaXdpTVExMHI0T21tdklDd0FSNDJxN3hwN21rM1JKL01lbnRQ?=
 =?utf-8?B?Rm9uQVVsSVNYeS95bW9XNnhObk1vOXp4OWMySWVuVWJVTjM2VjRXSWJQemtC?=
 =?utf-8?B?SlZPV0w3N1VOcnRTdS83V2tySno1YWEzS0xVWGZYaXI3eHdYME04YWRlUWNx?=
 =?utf-8?B?ZUUwZkFDUGg5SVd0YnNENjJuTjFxN1lBWTVwcVU3SE5vRU45c2NPM2wveXli?=
 =?utf-8?B?NXFLQ3FrQWJoUFBpejNrbnJrSlRDOFRkemh6aXVqc0J1dVF5YnAweG1ya1dC?=
 =?utf-8?B?K0MyMlVUeWJPdUtvU0FYMUNOZXBPeTV1ZXFjMzFZTjRRS01EbmYrd01MUjVn?=
 =?utf-8?B?eEVhYXB2K0N6ZjI1a1YzMXlJZElDL3lhbDBaV21mclNqa0cvVjBXUXErUGJj?=
 =?utf-8?B?Rm54dmxudE5RUWpud2dYWGcwanFwV0o0SHhRbytJUmNzejdIOTZrTnU1dXlx?=
 =?utf-8?B?U3Baak9FNWpCM3R1dnMvQ2Y2dzVYNVhLUGgzY2JWT2l2aDFabUFZeVdQYSt4?=
 =?utf-8?B?Q1UyQ1N5QW9kTjhvZHhPUitwL1BhNWl3d3JNd0l1SldOcTU1OUZwRGNiK2lG?=
 =?utf-8?B?RFlWN21JQmdHK3RYUlB4RTlHUDc1TDZaci9XVnhSTlFLT3N1cWJkeWNJTFZN?=
 =?utf-8?B?TUc4TGNQZmFPMTNaT3I1MVRJbytpb0hCQXJFZW1nT3RuOC92TFU5SHFUend5?=
 =?utf-8?B?MXVrQlhRckVLRFFHKy9GanB6TkxocEJVc3BReUd3bFp1WStHU2hJbmNyT2dk?=
 =?utf-8?B?QUhXUkpkaUxYODhDcCtockdEci9JTURDc0Vxc1p0MHhQQ2dKekNjN2k4SGwv?=
 =?utf-8?Q?cE9T7GKB+4G5c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5821c687-9289-4510-3337-08d8d9ad245c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 16:48:14.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH4US+T86jcbkN7j4HpTaSfOcWA0nzAbx/Q7RPoL9rGydAeD6hXbW8VRKzgYnrhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyNS4wMi4yMSB1bSAxNjozNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDItMjUgdW0gODo1MyBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4KPj4gQW0gMjUu
MDIuMjEgdW0gMDQ6MTUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+IE9uIDIwMjEtMDItMjQg
MTA6NTQgYS5tLiwgS2ltLCBKb25hdGhhbiB3cm90ZToKPj4+PiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Pj4KPj4+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4KPj4+Pj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNCwgMjAyMSA0
OjE3IEFNCj4+Pj4+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IGFt
ZC0KPj4+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+PiBDYzogWWFuZywgUGhpbGlw
IDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4Cj4+Pj4+IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQg
aWggY2FsbCB0byBwcm9jZXNzIHVudGlsCj4+Pj4+IGNoZWNrcG9pbnQKPj4+Pj4KPj4+Pj4gQW0g
MjMuMDIuMjEgdW0gMjI6MTAgc2NocmllYiBKb25hdGhhbiBLaW06Cj4+Pj4+PiBBZGQgSUggZnVu
Y3Rpb24gdG8gYWxsb3cgY2FsbGVyIHRvIHByb2Nlc3MgcmluZyBlbnRyaWVzIHVudGlsIHRoZQo+
Pj4+Pj4gY2hlY2twb2ludCB3cml0ZSBwb2ludGVyLgo+Pj4+PiBUaGlzIG5lZWRzIGEgYmV0dGVy
IGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhpcyB3aWxsIGJlIHVzZWQgZm9yLgo+Pj4+IEZlbGl4IG9y
IFBoaWxpcCBjb3VsZCBlbGFib3JhdGUgYmV0dGVyIGZvciBITU0gbmVlZHMuCj4+Pj4gRGVidWdn
aW5nIHRvb2xzIHJlcXVpcmVzIHRoaXMgYnV0IGl0J3MgaW4gZXhwZXJpbWVudGFsIG1vZGUgYXQg
dGhlCj4+Pj4gbW9tZW50IHNvIHByb2JhYmx5IG5vdCB0aGUgYmVzdCBwbGFjZSB0byBkZXNjcmli
ZSBoZXJlLgo+Pj4gT24gdGhlIEhNTSBzaWRlIHdlJ3JlIHBsYW5uaW5nIHRvIHVzZSB0aGlzIHRv
IGRyYWluIHBlbmRpbmcgcGFnZQo+Pj4gZmF1bHQgaW50ZXJydXB0cyBiZWZvcmUgd2UgdW5tYXAg
bWVtb3J5LiBUaGF0IHNob3VsZCBhZGRyZXNzIHBoYW50b20KPj4+IFZNIGZhdWx0cyBhZnRlciBt
ZW1vcnkgaXMgdW5tYXBwZWQuCj4+IFRob3VnaHQgc28uIEkgc3VnZ2VzdCB0byB1c2UgYSB3YWl0
X2V2ZW50KCkgaGVyZSB3aGljaCBvbiB0aGUgd2FpdGVyCj4+IHNpZGUgY2hlY2tzIGloLT5sb2Nr
IGFuZCBhZGQgYSB3YWtlX3VwX2FsbCgpIGF0IHRoZSBlbmQgb2YKPj4gYW1kZ3B1X2loX3Byb2Nl
c3MuCj4gUmlnaHQuIEkgdGhvdWdodCBhYm91dCB0aGF0IGFuZCBpdCBzaG91bGQgYmUgZWFzeSB0
byBhZGQuIFRoZSByZWFzb24gdG8KPiBzdWdnZXN0IGJ1c3kgd2FpdGluZyBmaXJzdCBpcywgdGhh
dCBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBpcyBzdXBwb3NlZCB0bwo+IGJlIGZhc3QuIFRoZSBJUlEg
aGFuZGxlciBpdHNlbGYgZG9lc24ndCBzbGVlcC4gU28gSSdkIGV4cGVjdCB0aGUgd2FpdAo+IHRp
bWUgdG8gYmUgc2hvcnQgZW5vdWdoIHRoYXQgc2xlZXBpbmcgYW5kIHNjaGVkdWxpbmcgaXMgbm90
IHdvcnRoIGl0LgoKV2VsbCB0aGUgcGFnZSBmYXVsdCBJUlFzIGFyZSBwcm9jZXNzZWQgaW4gYSB3
b3JrIGl0ZW0sIHNvIHdlIGJ1c3kgd2FpdCAKZm9yIGFub3RoZXIgdGhyZWFkIGhlcmUgYW5kIG5v
dCBpbnRlcnJ1cHQgY29udGV4dC4KClRoaXMgaW4gdHVybiBjYW4gbGVhZCB0byBzdGFydmF0aW9u
IG9mIHRoZSB3b3JrIGhhbmRsZXIgYW5kIHNvIGEgbGlmZSAKbG9jayBhcyB3ZWxsLgoKPgo+Cj4+
IEkgd29uJ3QgdG91Y2ggcnB0ciBvciB3cHRyIGF0IGFsbCBmb3IgdGhpcy4KPiBOb3Qgc3VyZSB3
aGF0J3MgeW91ciBpZGVhIGhlcmUsIHVzaW5nIGloLT5sb2NrLiBJcyBpdCB0byBjb21wbGV0ZWx5
Cj4gZHJhaW4gYWxsIElSUXMgdW50aWwgdGhlIElIIHJpbmcgaXMgY29tcGxldGVseSBlbXB0eT8K
CkNvcnJlY3QuCgo+IFRoYXQgY2FuCj4gbGl2ZS1sb2NrLCBpZiB0aGUgR1BVIHByb2R1Y2VzIElS
UXMgZmFzdGVyIHRoYW4gdGhlIGtlcm5lbCBjYW4gcHJvY2Vzcwo+IHRoZW0uIFRoZXJlZm9yZSBJ
IHdhcyBsb29raW5nIGF0IHJwdHIgYW5kIHdwdHIgdG8gZHJhaW4gb25seSBJUlFzIHRoYXQKPiB3
ZXJlIGFscmVhZHkgaW4gdGhlIHF1ZXVlIHdoZW4gdGhlIGRyYWluIGNhbGwgd2FzIG1hZGUuIFRo
YXQgYWxzbwo+IGVuc3VyZXMgdGhhdCB0aGUgd2FpdCB0aW1lIGlzIGJvdW5kZWQgYW5kIHNob3Vs
ZCBiZSBzaG9ydCAodW5sZXNzIHRoZQo+IHJpbmcgc2l6ZSBpcyBodWdlKS4KCkNvcnJlY3QgYXMg
d2VsbCwgYnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCBKb25hdGhhbidzIGltcGxlbWVudGF0
aW9uIAppcyBub3QgZXZlbiByZW1vdGVseSBjb3JyZWN0LgoKU2VlIHdoZW4geW91IGxvb2sgYXQg
dGhlIHJwdHIgYW5kIHdwdHIgeW91IGNhbid0IGJlIHN1cmUgdGhhdCB0aGV5IApoYXZlbid0IHdy
YXBwZWQgYXJvdW5kIGJldHdlZW4gdHdvIGxvb2tzLgoKV2hhdCB5b3UgY291bGQgZG8gaXMgbG9v
ayBhdCBib3RoIHRoZSBycHRyIGFzIHdlbGwgYXMgdGhlIG9yaWdpbmFsIHdwdHIsIApidXQgdGhh
dCBpcyB0cmlja3kuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVs
aXgKPgo+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IFJlZ2FyZHMsCj4+PiAgwqAg
RmVsaXgKPj4+Cj4+Pgo+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBGZWxpeCBLdWVobGluZyA8ZmVsaXgu
a3VlaGxpbmdAYW1kLmNvbT4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9u
YXRoYW4ua2ltQGFtZC5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICDCoMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jIHwgNDYKPj4+Pj4gKysrKysrKysrKysrKysrKysrKysr
KysrKy0KPj4+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHzCoCAy
ICsrCj4+Pj4+PiAgwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2loLmMKPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2loLmMKPj4+Pj4+IGluZGV4IGRjODUyYWY0ZjNiNy4uY2FlNTBhZjk1NTlkIDEwMDY0NAo+
Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKPj4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCj4+Pj4+PiBAQCAt
MjIsNyArMjIsNyBAQAo+Pj4+Pj4gIMKgwqDCoCAqLwo+Pj4+Pj4KPj4+Pj4+ICDCoMKgICNpbmNs
dWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgo+Pj4+Pj4gLQo+Pj4+Pj4gKyNpbmNsdWRlIDxsaW51
eC9wcm9jZXNzb3IuaD4KPj4+Pj4+ICDCoMKgICNpbmNsdWRlICJhbWRncHUuaCIKPj4+Pj4+ICDC
oMKgICNpbmNsdWRlICJhbWRncHVfaWguaCIKPj4+Pj4+Cj4+Pj4+PiBAQCAtMTYwLDYgKzE2MCw1
MCBAQCB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdAo+Pj4+PiBhbWRncHVfaWhfcmlu
ZyAqaWgsIGNvbnN0IHVpbnQzMl90ICppdiwKPj4+Pj4+ICDCoMKgIH0KPj4+Pj4+ICDCoMKgIH0K
Pj4+Pj4+Cj4+Pj4+PiArLyoqCj4+Pj4+PiArICogYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2lu
dF9wcm9jZXNzIC0gd2FpdCB0byBwcm9jZXNzIElWcyB1cCB0bwo+Pj4+Pj4gK2NoZWNrcG9pbnQK
Pj4+Pj4+ICsgKgo+Pj4+Pj4gKyAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPj4+Pj4+
ICsgKiBAaWg6IGloIHJpbmcgdG8gcHJvY2Vzcwo+Pj4+Pj4gKyAqCj4+Pj4+PiArICogVXNlZCB0
byBlbnN1cmUgcmluZyBoYXMgcHJvY2Vzc2VkIElWcyB1cCB0byB0aGUgY2hlY2twb2ludCB3cml0
ZQo+Pj4+PiBwb2ludGVyLgo+Pj4+Pj4gKyAqLwo+Pj4+Pj4gK2ludCBhbWRncHVfaWhfd2FpdF9v
bl9jaGVja3BvaW50X3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4+Pj4gKmFkZXYsCj4+
Pj4+PiArc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCkKPj4+Pj4+ICt7Cj4+Pj4+PiArdTMyIHBy
ZXZfcnB0ciwgY3VyX3JwdHIsIGNoZWNrcG9pbnRfd3B0cjsKPj4+Pj4+ICsKPj4+Pj4+ICtpZiAo
IWloLT5lbmFibGVkIHx8IGFkZXYtPnNodXRkb3duKQo+Pj4+Pj4gK3JldHVybiAtRU5PREVWOwo+
Pj4+Pj4gKwo+Pj4+Pj4gK2N1cl9ycHRyID0gUkVBRF9PTkNFKGloLT5ycHRyKTsKPj4+Pj4+ICsv
KiBPcmRlciByZWFkIG9mIGN1cnJlbnQgcnB0ciB3aXRoIGNoZWNrdHBvaW50IHdwdHIuICovCj4+
Pj4+PiArbWIoKTsKPj4+Pj4+ICtjaGVja3BvaW50X3dwdHIgPSBhbWRncHVfaWhfZ2V0X3dwdHIo
YWRldiwgaWgpOwo+Pj4+Pj4gKwo+Pj4+Pj4gKy8qIGFsbG93IHJwdHIgdG8gd3JhcCBhcm91bmTC
oCAqLwo+Pj4+Pj4gK2lmIChjdXJfcnB0ciA+IGNoZWNrcG9pbnRfd3B0cikgewo+Pj4+Pj4gK3Nw
aW5fYmVnaW4oKTsKPj4+Pj4+ICtkbyB7Cj4+Pj4+PiArc3Bpbl9jcHVfcmVsYXgoKTsKPj4+Pj4+
ICtwcmV2X3JwdHIgPSBjdXJfcnB0cjsKPj4+Pj4+ICtjdXJfcnB0ciA9IFJFQURfT05DRShpaC0+
cnB0cik7Cj4+Pj4+PiArfSB3aGlsZSAoY3VyX3JwdHIgPj0gcHJldl9ycHRyKTsKPj4+Pj4+ICtz
cGluX2VuZCgpOwo+Pj4+PiBUaGF0J3MgYSBjZXJ0YWluIE5BSyBzaW5jZSBpdCBidXN5IHdhaXRz
IGZvciBJSCBwcm9jZXNzaW5nLiBXZSBuZWVkCj4+Pj4+IHNvbWUKPj4+Pj4gZXZlbnQgdG8gdHJp
Z2dlciBoZXJlLgo+Pj4+IFRoZSBmdW5jdGlvbiBpcyBtZWFudCB0byBiZSBqdXN0IGEgd2FpdGVy
IHVwIHRvIHRoZSBjaGVja3BvaW50Lgo+Pj4+IFRoZXJlJ3MgYSBuZWVkIHRvIGd1YXJhbnRlZSB0
aGF0ICJzdGFsZSIgaW50ZXJydXB0cyBoYXZlIGJlZW4KPj4+PiBwcm9jZXNzZWQgb24gY2hlY2sg
YmVmb3JlIGRvaW5nIG90aGVyIHN0dWZmIGFmdGVyIGNhbGwuCj4+Pj4gVGhlIGRlc2NyaXB0aW9u
IGNvdWxkIGJlIGltcHJvdmVkIHRvIGNsYXJpZnkgdGhhdC4KPj4+Pgo+Pj4+IFdvdWxkIGJ1c3kg
d2FpdGluZyBvbmx5IG9uIGEgbG9ja2VkIHJpbmcgaGVscD/CoCBJIGFzc3VtZSBhbiB1bmxvY2tl
ZAo+Pj4+IHJpbmcgbWVhbnMgbm90aGluZyB0byBwcm9jZXNzIHNvIG5vIG5lZWQgdG8gd2FpdCBh
bmQgd2UgY2FuIGV4aXQKPj4+PiBlYXJseS7CoCBPciBpcyBpdCBiZXR0ZXIgdG8ganVzdCB0byBw
cm9jZXNzIHRoZSBlbnRyaWVzIHVwIHRvIHRoZQo+Pj4+IGNoZWNrcG9pbnQgKG1heWJlIGFkanVz
dCBhbWRncHVfaWhfcHJvY2VzcyBmb3IgdGhpcyBuZWVkIGxpa2UgYWRkaW5nCj4+Pj4gYSBib29s
IGFyZyB0byBza2lwIHJlc3RhcnQgb3Igc29tZXRoaW5nKT8KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+
Pgo+Pj4+IEpvbgo+Pj4+Cj4+Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4gKy8qIHdhaXQgZm9yIHJw
dHIgdG8gY2F0Y2ggdXAgdG8gb3IgcGFzcyBjaGVja3BvaW50LiAqLwo+Pj4+Pj4gK3NwaW5fYmVn
aW4oKTsKPj4+Pj4+ICtkbyB7Cj4+Pj4+PiArc3Bpbl9jcHVfcmVsYXgoKTsKPj4+Pj4+ICtwcmV2
X3JwdHIgPSBjdXJfcnB0cjsKPj4+Pj4+ICtjdXJfcnB0ciA9IFJFQURfT05DRShpaC0+cnB0cik7
Cj4+Pj4+PiArfSB3aGlsZSAoY3VyX3JwdHIgPj0gcHJldl9ycHRyICYmIGN1cl9ycHRyIDwgY2hl
Y2twb2ludF93cHRyKTsKPj4+Pj4gU2FtZSBvZiBjb3Vyc2UgaGVyZS4KPj4+Pj4KPj4+Pj4gQ2hy
aXN0aWFuLgo+Pj4+Pgo+Pj4+Pj4gK3NwaW5fZW5kKCk7Cj4+Pj4+PiArCj4+Pj4+PiArcmV0dXJu
IDA7Cj4+Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4gIMKgwqAgLyoqCj4+Pj4+PiAgwqDCoMKgICog
YW1kZ3B1X2loX3Byb2Nlc3MgLSBpbnRlcnJ1cHQgaGFuZGxlcgo+Pj4+Pj4gIMKgwqDCoCAqCj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgK
Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+Pj4+IGlu
ZGV4IDZlZDRhODVmYzdjMy4uNjgxN2YwYTgxMmQyIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+Pj4+PiBAQCAtODcsNiArODcsOCBAQCBpbnQg
YW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+Pj4gc3Ry
dWN0IGFtZGdwdV9paF9yaW5nICppaCwKPj4+Pj4+ICDCoMKgIHZvaWQgYW1kZ3B1X2loX3Jpbmdf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0Cj4+Pj4+IGFtZGdwdV9paF9y
aW5nICppaCk7Cj4+Pj4+PiAgwqDCoCB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdCBh
bWRncHVfaWhfcmluZyAqaWgsIGNvbnN0Cj4+Pj4+PiB1aW50MzJfdCAqaXYsCj4+Pj4+PiAgwqDC
oMKgwqAgdW5zaWduZWQgaW50IG51bV9kdyk7Cj4+Pj4+PiAraW50IGFtZGdwdV9paF93YWl0X29u
X2NoZWNrcG9pbnRfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+Pj4+PiAqYWRldiwKPj4+
Pj4+ICtzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+Pj4+ICDCoMKgIGludCBhbWRncHVf
aWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0Cj4+Pj4+IGFtZGdw
dV9paF9yaW5nICppaCk7Cj4+Pj4+PiAgwqDCoCB2b2lkIGFtZGdwdV9paF9kZWNvZGVfaXZfaGVs
cGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4+Pj4gIMKgwqAgc3RydWN0IGFtZGdw
dV9paF9yaW5nICppaCwKPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2ZlbGl4Lmt1ZWhsaW5nJTQw
YW1kLmNvbSU3Qzg0ZDg1ZTU0YmRjYjQ1OTNlMDdmMDhkOGQ5OTRiZTc3JTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ5ODU4MDE2NzMxMzE5MyU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1SdlJIQjlsNE8lMkJw
YnBvZ1VGS1Vtbk1Ha3FLbmVjd1FDWVJIcmt4SUNEcVUlM0QmYW1wO3Jlc2VydmVkPTAKPj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
