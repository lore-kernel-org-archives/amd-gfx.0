Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB79C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA03A65015
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03A65015
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C366EB46;
	Fri,  5 Mar 2021 15:18:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450BE6EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahLE9pbhe/uAj5HzXpwX6uV16njYJmJdkFLH4S4qD5sJ1zIvaAkX3kvWyZ/LV6+yLSReV7Hij05U3G5e+yfwL/LuioRle6Z6KBPu1IYCTaThlEj+r2Nx785a+s0/xUHoC3/VC7pPchl219XnLrOyDZv7iI5UvsJVlnXWR3IV3ccj/K5AahmVBQF5enbBf3b4aMtIHrVtSNdxGMC/2gyTvgOMPVKWetFpY2As3fa0bGzBUqcXDYPJZR6c1W6k1bX8I3jy0g0BrQdi5Zl9e/ZHbLbO5EiB2VmXadHVi3S/Jyd1iFXXGA0hJmuZfyoMrl9hQrskIjaiCkDr27Ouqbm2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2R3/GlZCUtKwvVAl65l/1e7VovZ3WTs/B9I3NLGenc=;
 b=QhByzGd/lpdWJa6rcivzddcoKJLuEBAlqAGZCkn1tE8txnM3njhfocxNLoHGZUzzQFb1BmFu8TT40O5nvuUj1w3g+mnQlS8/cYusGPR8XsadYjKR0ySt05nxE9/IzykQogDa/5YdHbnA9lrPl3Qg2sO6X1o1JdmW2Rv0uQRZfcUP5CqWCsg939WjR2BP+o9287OAbhiW82F9RN2/hMv30ijfuk6LCFqfcsCYEcCTGojSYH2lqHjmJ3VaQ7Susi+K41H7HMu9K5MQltakknca44iR5t+LvoobxcXkSqPMJn8x+g8Krql0yYolT78iAnqYyACIJbIHbsinGVEPncecCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2R3/GlZCUtKwvVAl65l/1e7VovZ3WTs/B9I3NLGenc=;
 b=bm6Q7TopEXu/Fz7YtjRuxN3U4azJYkDtRS/5fupw7NCg6yNEnyTGqZ2wz3BNGR8Nb4jzbjYlAwLpdm4P+GDAt2R5VEH1RIzGdjOQuheyd+Jq090wU0xW5XpalSmbBFSxxU7nwMa5lGFWaheYyyhqPG5PJlZseRmeG/m3stl0Pk0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Fri, 5 Mar
 2021 15:18:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 15:18:38 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: Nirmoy <nirmodas@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <015f2823-e03f-1cc0-6b9f-4c6109225863@gmail.com>
 <5f17b6b0-15b6-bcfc-9576-6d5c8ee70f0f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e88ca8f6-971b-caaf-a967-0554008baaf4@amd.com>
Date: Fri, 5 Mar 2021 16:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <5f17b6b0-15b6-bcfc-9576-6d5c8ee70f0f@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ee4e:e545:33e0:7359]
X-ClientProxiedBy: AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359]
 (2a02:908:1252:fb60:ee4e:e545:33e0:7359) by
 AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 15:18:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37b6129b-07d9-4097-85fb-08d8dfe9f3a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB420510C54B57E020934313D583969@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGnfllooQPjHmXyDRvVHOQMDcZg9yhNBtpSYjrFbQMsBeRqzvSeAuKRapUilJFPwiHAtLs60H0siPC7NUTkczl1jTGiNMei1SO8pk0sEoexWkOny4UlVGLcsmBaZwJKg39jWXNdnDc1Z1yRbcyc2Lepo8ciFjRMNOIyENHaVDU8GvBRMY80hCpyl8y4ULpyFenjdPPo7gJeJVN2mgTgq/EVLLsvS881qMRVUQ+nDL+NrOCSCoSdymdYf8VKF78s5o5/cq4eXfiPc1+VQHEzsTpyGWG77JCcH2NZzUqYDf8BuT7r7BgVvTiXlFiUwgOfUaisu82cZWl4n+f8gRMXo09RINI3zp7SdBxkI2iDdOzj7QIkaAxlkKIXZwGj0liELwJ39n62oMPVP4xwH//igS3diTNs/p07C2G37Hb3Blk0tEQzo+VzvC7CP9oKjCAEWgNxSQr5MlIse2wvJ4VMyWcqFjXKZVLVuMS+EDZ0iWmMr8o+aBden7/qCs40JjWE0mYm6ZgVRwnDzGy05fQoe7vBdaiyzGmrLH0kgQyO1uKNMObVM+1+TiypzUAD0z4pmJsUvVbKTkkEMz24cvSDGoyZG4TI4VeRJ4qrqI2b3KTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(5660300002)(86362001)(8936002)(6486002)(36756003)(2616005)(53546011)(6666004)(31686004)(2906002)(110136005)(52116002)(186003)(478600001)(4326008)(16526019)(31696002)(66556008)(316002)(66476007)(8676002)(66946007)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmxwWmtmeGI4dnNDMEhMYVhWQ0FUSmhvejRxOG9wb1FKRHIrcko1T0xkdGM4?=
 =?utf-8?B?Z0x4ak9aM0c5ZnlkN2N1STJYQ0NGME5mekVNM05aWDFzTEoyc3Z6Tk04bFY0?=
 =?utf-8?B?bFlpVGpndy9DSGhyR0NER2RNMnpWeWVWTE5YQi9DVkl4YXM0dUFhc0Nhbkxj?=
 =?utf-8?B?UERlOU1WaDBoTUg4UkM3dVY5eWxwV0xJNDZUMlNYalJhUkcyQzhvb1Bvb2M3?=
 =?utf-8?B?MjZIVkkwcmthdnRZMVE3bk5nS3lYNTJ5VG5jbHVBNWFwZEQ2UHI5U1ZQbmVr?=
 =?utf-8?B?VWxxVCtqS1lIb2xla0ExdzAvMm5vWjlWZ1dDRzU2alovUFhOQVNEVU5TNDdP?=
 =?utf-8?B?emc1V1NGbDRUVkp2V3hWWHhIM3NZVU9FYTlMY3lkVHlrYmg1YmFCR1IvZkhy?=
 =?utf-8?B?cFhBeDd6MFhYTDA5V2tET3pxWERHQ0lFTDFPQWtyLzJCYWVTamVySFJ5VUh5?=
 =?utf-8?B?K2Fva0lLMnZuYmVZbC84b0VFV3FLc0RPclFCTThmdjYraFp3N1JkdlBsY29M?=
 =?utf-8?B?VVZQL0tzV3dadEdxamgveUpoM3NpWmZia0QxRU4wWDJ0ckNia08xblo5aERC?=
 =?utf-8?B?UGVvRXpmNVExSlNYNE96MU1vUDBCZjB4b1UzSHo0VUZhV2d6bzJTNEI5NFli?=
 =?utf-8?B?NnNLOWV6TzZvK2EzN2xXMXM1MDYzNWY4TzJ6R3dMSENaKytlTlU3d0g1Z3ZO?=
 =?utf-8?B?VnZQUVdjREVuRVR1anVVd2NYRjRrNi9sVENBb1N6SjI1VlQ0RDgwVnpLN25p?=
 =?utf-8?B?YjdheGNkeit5K2lrdGxXNmhFZHErWXBMNzNESHl2SkFpNUx0bEI1UDFyeE5W?=
 =?utf-8?B?UlZqOXV4cEdUd00yWXVPL2tuWk9NaW9Vc01FTjQrbjdJdXdTTUxZMzhFbnNX?=
 =?utf-8?B?RGprSkpJb0U0ck5WckorMFhRYlRRVVZkN1V2SHd1Q1k2a05ObHlpQ01zZy9q?=
 =?utf-8?B?V3E0VkZzSnFKUTZUbnJtSFFrTlFkSC9odG8zdWpwU0d3TTFaM3laeXhTd000?=
 =?utf-8?B?SHBNOU50K2lWSCttL0pWaE9KZ1BBZlptRzU1V080NFEvczhCdTU2c2l6Qlhs?=
 =?utf-8?B?U3YwR29sOVArcFRSOGsvVjZwb3NTbSt6b2pJbDh2VGMxSkZvTlBELzlLQWNI?=
 =?utf-8?B?Z3BUOE9oeEUzZVl3YVNveU5LNk8rVUFCOHAyUGp3QnBaNjVWeFJxOXVYdVJa?=
 =?utf-8?B?anpCT3NnMTIxbFY4VGFNMGp5dmxnNFpWNTJVSGxodkFVTXdCalNHbHBqTWFh?=
 =?utf-8?B?UGZHTmJVanU3cHRoMzd2YitDN3gxQUwyTFhDdGpwUVpXWTRDYTdleXkzeGV3?=
 =?utf-8?B?Wm85QUNZSTB1VzVFS2VSWm9CYmhOR1Y0ZEl3R2oxNmJrSEI5QVU3bUI1S2xQ?=
 =?utf-8?B?STFWTVpNcG1lWjhJcTkvQnhKZytNRDk3Y2pvZWV1b2RHREJwbllxNUsvWFBL?=
 =?utf-8?B?ZWMrazVNcjlBbmFuSWRpMGlKS0FSOTdiQm1UcUpub3grZTRrQk82czc4OXFk?=
 =?utf-8?B?a29aY0ZCejN1Vm1mL2piRnBiL2NUUFlSTjkvUGgzSXhyclBvRnBaMUJGVnFE?=
 =?utf-8?B?Y1Joa1BMMG1RUit3NjZiclVSLzhxMHJ3NEx0bFRuQXozSXNUK0E3T1o3K0FI?=
 =?utf-8?B?VGdBRGhKMS9aVUdhMkxlQitDdWIydmpodkhzUFhHVzFUVWNERmUycGhIMk5B?=
 =?utf-8?B?S2Z4bXd4ZlhURnpCK00vdnJyYzFuckVESE93eVVFTXRySzB0OGpTUkJmelBw?=
 =?utf-8?B?YU9vaUVZU3dFUmxKNzBJbk85RFZGUm90YUdja1RXd3JTWnBOT0RIV3ZGV3Mv?=
 =?utf-8?B?SmxjRXl4YzN3R21ZV2RWTGMyR0lOOTFRZnBHS21YS2Y4MTB5UUM5RFBVOGhI?=
 =?utf-8?Q?RSZgnc+Fya42z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b6129b-07d9-4097-85fb-08d8dfe9f3a7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:18:38.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPJq/JRM9J9N09eZqRG8r/sEWu8DSG1sTDkKxLuoBdW/jXPNiLHz45itBUcfPv1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNS4wMy4yMSB1bSAxNTo0OCBzY2hyaWViIE5pcm1veToKPgo+IE9uIDMvNS8yMSAzOjM3
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+Pgo+PiBBbSAwNS4wMy4yMSB1bSAxNToz
NSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+PiBBbGxvdyBhbGxvY2F0aW5nIEJPIHN0cnVjdHVyZXMg
d2l0aCBkaWZmZXJlbnQgc3RydWN0dXJlIHNpemUKPj4+IHRoYW4gc3RydWN0IGFtZGdwdV9iby4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+
PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8
IDIgKysKPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8
IDEgKwo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIAo+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4+IGluZGV4IDBi
ZDIyZWQxZGFjZi4uNzQ1MzkzNDcyNTY0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4+IEBAIC01NTEsNiArNTUxLDggQEAgc3RhdGljIGlu
dCBhbWRncHVfYm9fZG9fY3JlYXRlKHN0cnVjdCAKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
PiDCoCDCoMKgwqDCoMKgIGFjY19zaXplID0gdHRtX2JvX2RtYV9hY2Nfc2l6ZSgmYWRldi0+bW1h
bi5iZGV2LCBzaXplLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvKSk7Cj4+PiArwqDCoMKgIGlmIChicC0+
Ym9fcHRyX3NpemUgPCBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibykpCj4+PiArwqDCoMKgwqDCoMKg
wqAgYnAtPmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8pOwo+Pgo+PiBZb3Ug
c2hvdWxkIHByb2JhYmx5IHJhdGhlciBmaXggdXAgYWxsIGNhbGxlcnMgYW5kIG1ha2Ugc3VyZSB0
aGF0IHRoZSAKPj4gcGFyYW1ldGVyIHN0cnVjdHVyZSBpcyBjb3JyZWN0bHkgZmlsbGVkIGluLgo+
Cj4KPiBPayB3aWxsIHJlc2VuZCB3aXRoIHRoYXQgY2hhbmdlLgoKWW91IGFyZSB0byBmYXN0LCBs
ZXQgbWUgYXQgbGVhc3QgY29tbWVudCBvbiBhbGwgcGF0Y2hlcyA6KQoKQ2hyaXN0aWFuLgoKPgo+
Cj4gVGhhbmtzLAo+Cj4gTmlybW95Cj4KPgo+Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiDCoCDCoMKg
wqDCoMKgIGJvID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGFtZGdwdV9ibyksIEdGUF9LRVJORUwp
Owo+Pj4gwqDCoMKgwqDCoCBpZiAoYm8gPT0gTlVMTCkKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggCj4+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4gaW5kZXggOGNkOTZjOTMzMGRkLi44NDhk
YzBhMDE3ZGQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuaAo+Pj4gQEAgLTQwLDYgKzQwLDcgQEAKPj4+IMKgIHN0cnVjdCBhbWRncHVfYm9fcGFy
YW0gewo+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
aXplOwo+Pj4gwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnl0
ZV9hbGlnbjsKPj4+ICvCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJv
X3B0cl9zaXplOwo+Pj4gwqDCoMKgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZG9tYWluOwo+Pj4gwqDCoMKgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJlZmVycmVkX2RvbWFpbjsKPj4+IMKgwqDCoMKgwqAgdTY0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZsYWdzOwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
