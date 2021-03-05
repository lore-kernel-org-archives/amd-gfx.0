Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F722C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4091564EE1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4091564EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E366EACD;
	Fri,  5 Mar 2021 03:59:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC00A6EACB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 03:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG5c95O5hqhEDCnwLjEvh0+MdnucyHfYBi0FdqrKO+ta6mnfZ3NXoMSs8ZwE+DgP2xN1bETylaBioPvar47klewjMWkE+OuyV9JXaxB2UzUR6uOV/Kj2CIKC1EuiJiIcNeGkCNFSiabIq0ZdsiGSotvxMTkHzEtwLR2vSEw64jqFn0ydbT1NfgRwNi8Hf5mkWaosYfzHjofrLdec7mnlct7/Nn/UFy6VMp8dxL+oQQEI1APU942vL+VAI60gPbROtNwAO257vwWnGdRBLvDpItbjhd5HY12ZP4ghF2LPCcXHl8Ddy0LpqgBp4Q5gabsqm1vC+edoVJKS+xyK279a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfnfq/+SbY1ZHQXgfsHK53cr57GdSihbgFeHMWVz2/Q=;
 b=MxhFwVGlL+qs4t8HSeophdtt0YaGpr08vog6NsorCPZTTbqisAuxqB4fkC6RGXqNDsUVm9WLxG/jVVGFLjKRBQrgrGYEoyR2EgouzGjcEfjStN3eFEvKEBrZNIm0AEPmubU92D84MqWajixpzXKdVoKSXEl86DqL+oZEY8wWOdlWIsGnOqjo1GNAnS9xRQ3gHKSZ0rFj/F+iV2Zeoh+BNcSwJosN+uX6kaiCw3XKjni6Kxh620SHnLe7mtTsFEmq/anrIqh63dZbGWBOVZzEQWT6Ro0945hF7hrFSfwk977u3Vt8zsqFARhgYN1Z4dbuDvFEpS5CMySgn9obevRN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfnfq/+SbY1ZHQXgfsHK53cr57GdSihbgFeHMWVz2/Q=;
 b=P4FE5YaMvw0W7oDjUqUkP8JskJwKv3M7FwTjqoQid6Q0g7RU14VRCixVlzK0XMTI9koAtO0e7f6N6Mxx91IIwiuPIYLQToq/f5HlVPPFafYhESX2uvzeHZ4HtTnMT9KMFdn+CHxfBOsMZTuJEY6aXqQ14M30XOvDruyelvmMmO8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 03:59:31 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.030; Fri, 5 Mar 2021
 03:59:30 +0000
Subject: Re: [amdgpu] Can compute kernels with different VMIDs run
 concurrently on the gpu hardware
To: amd-gfx@lists.freedesktop.org
References: <CAGztBWWAv2ei=JvJvG6hvGp_275rFwQvFtzSaC4kbuCDgNBZEQ@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f72da304-c744-4d38-d9ec-b9cf26dc267b@amd.com>
Date: Thu, 4 Mar 2021 22:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAGztBWWAv2ei=JvJvG6hvGp_275rFwQvFtzSaC4kbuCDgNBZEQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Fri, 5 Mar 2021 03:59:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d907700-88ee-419f-8e34-08d8df8b143a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-Microsoft-Antispam-PRVS: <BL0PR12MB244918D73547C7DD739EF2AA92969@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzowdtnf0tgM4aJ0JER9yri5KfaNQD8tZzW4dNt5sG4BdoRtsBor/dTs7VTY+037BMH9SYDAyYr3v3Xe+pA6XYu8Q6ypGypGj0r25CFV5m3eeRTNyMDb0M2aMhpA7MRDRChZ4na4uGtRxqQTeX4Rxzjq7luld1Uc9CZTKQPjOOegscQlj5JZRPMr2N+3j2OnWGSNQo/2j4gVgYzk91/50/8Ohp8SPMPigIfRo5uVDFua3jurZn4Daodr3lUJtoFVnkzqptowk/WUsjZ4B1P5d8u6FsX1F7OD391bO7AvxXwLj02+EJlsDbXXHMazzKnr0Rtz4WYbC2EE88drSOy0otDgPITIVyG4oAd3+fFVVoRP+592cBnRY/h2HDa8o8kj3PAXunv88b7nQMZisDkOYFzDMssBkwwutquciKrEw1x9rIDlvA5S37f1JdpaeGA8HdXFdkqIY4Xm3XQo5OcjzJBnayCveLTKa7ijNLbYOVECx78fLHxjb94k0dG98xyii78Qnr+5t03Io5pJzN95GYC6lxwv/JYH+B4GHBJrZgPhfm1/lNAbjvL71yg1EYc0VFnho61SCgR1DybQ0Vstbf+tp+R5PmQ0j7vS11pe5cT6Dqk6V4ydOpwIy+yoRsd78oXhOLndtlr4JgMBNxjPUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(26005)(44832011)(83380400001)(6666004)(86362001)(31696002)(16576012)(316002)(36756003)(16526019)(31686004)(66946007)(4744005)(956004)(186003)(6916009)(478600001)(52116002)(5660300002)(8676002)(6486002)(66556008)(2906002)(66476007)(2616005)(8936002)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTFIQmVNczNYVU54QVJkNVZ3RzREQWs3UzFpb2l1cDJoV2MxYndsNGc5THF3?=
 =?utf-8?B?OFcvbVNkYWZ0S3pVeVhYcjJ1dVQyTWJoM09FcHk2SWRCWWVmSVFWemt3dU83?=
 =?utf-8?B?d2x5N2hzKzR0M2g1K1Ntbkh0VmltWmNyTlB5bTBrZXN1MkJjNEkxTnFidzlF?=
 =?utf-8?B?V3hWU1ZvWjE5ZEU4OElLOVczaGZ5NERTK3pwbWF1c3dvRkhvcDc2a3J1Rk5x?=
 =?utf-8?B?RU5SUEk1bEc4anREeERjVW1HdG5nSXNNTTF5ak9BUnZ0cGVWcFFHSFNVUFlm?=
 =?utf-8?B?VHd2TmlUbEszdjFlK09ySjNNY0lDQ1hSV1JvbVpoUDd2MFJsWHBsNCtvZ0xu?=
 =?utf-8?B?SVN4R2kwUjQ0ZDM4bW1qajFaWEJ4Z01QSHNqQjkrcXBDYmVMS2szMWZtS1JJ?=
 =?utf-8?B?MlpHanBRQzFxdklRNmNUaDlHdzcwblF1cG1VbzBwazJsUi8zdlZ2SHAyaXlo?=
 =?utf-8?B?WDVmd3FpRERDclVIcy9YeXZUcFkxcG5wRnhBaFdFVjlNeVhOek54TmxQd0E0?=
 =?utf-8?B?M3RhNDV4Vm1tNVRjSlN5NTRnTkYzajgweHVqdVlrNTRJK0x6VEg3K1lrQllx?=
 =?utf-8?B?dHBwSGVoTmJHOGNxMEh1aUpVaGFlUTIyR2lxTTBaSjA0cUdtRkoxa0szSFRB?=
 =?utf-8?B?M0QzR0JWcHNWcUlYeFo1YU5NT1YxeTlxc2Z1THBocTVNRXZSM1VXOVBEV25n?=
 =?utf-8?B?eFRYQWEvWUJiTm5KTjdZbldJdUkyd1laMU1QQWR0allYeW10L1VxR3BwWGMv?=
 =?utf-8?B?MlQ4dGFEckhLaDVPK2c0dGE2SlZPUUtJN09hdkZ0a0lUT2pKQ3NMcGpRQWEw?=
 =?utf-8?B?S2NJbkNkbjJwOHlvRDZNV3llRmt1d2gxV045OWVNVVR3S0FyQkY2V2RMcnZ3?=
 =?utf-8?B?Z0s5L1VRbWdCekRSK0JnaDZKUmd4ZFFwOGxrb1ExTlhPSExBMDlCQjhlYzIw?=
 =?utf-8?B?aWNldjJESXpuMnZQaktlUmVaWVBXVi9ldTFGa1NYa0p0N0RuU1hCbEgzbGZ6?=
 =?utf-8?B?Z3pkbDF5OFRYM2swU1hOUitTRUZ5aks0c1JpWjgyaGlwTUlYb2hNSW44Z0dT?=
 =?utf-8?B?d0pBcnVNVGdpVkhjWlA0UXFGaEgzbmtPTkdsR2tuclZJNjYzNUd3VTJjZ1FU?=
 =?utf-8?B?ZWQxQmdrN1I4SzRFTVlaOVpmZk9IL0tQcVM2K1lmd09PdmZQUkZjUDduNFYv?=
 =?utf-8?B?UG9lYzd4U1EzY050QkJzT01jYTlPUE1PWWw5NHRKTm5hY2JQTVdEMWlSQmZY?=
 =?utf-8?B?LzQ3SFNwOGpmeVpsYVZ4M0ZMZ0lIbFplaFNlK0ppZUNtd2FaWlFGaGcwS3U5?=
 =?utf-8?B?c09FUitKczhCdXRITGVGVHJFdHludzNLRXZReTVxZXczWFlkOGQ2Mjl3aFp1?=
 =?utf-8?B?NEpxNGtZMUcyYkYrTHY1T2ZwcTd3YXJIUXhNbjcxWGpybm85amNSNWc2azZE?=
 =?utf-8?B?cHdkVEEzSnBkZ0dNa2pweUxhUWlCdmNuQnJJWFBBVUVCQ3pNYkFaMTBaMUtj?=
 =?utf-8?B?SDJOVi82U3BjOFZETkdSTVBBVVRpNW5zYUVqb2lTZWdtMzU4UXlDcmlPVWZr?=
 =?utf-8?B?VmZ1VjByNk9BV05WYWxhMU84VWVrbXJhSHp0dUxUTDh6ZjVMUGVqRHhvRUN6?=
 =?utf-8?B?b2ZZckM4dUVGY1pJOC9hNm5LekRRaTVybnlnR2lvekhlK1FzWllHZS9BZ1pL?=
 =?utf-8?B?clB1dGtnanNxdkNhYnhzSmkyZnBjL2xESXN0aXFjZWVFdXc2UVJtS21mWDZn?=
 =?utf-8?B?aHJ5RmJxYUlIN2tNa3NxRGlPNDhsZ3NzUURveWRQNWtYamxyb21CaU5kN1BS?=
 =?utf-8?B?SklNWHROU1JTK0RzSHZWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d907700-88ee-419f-8e34-08d8df8b143a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 03:59:30.8493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOFJphcHEcGZnf/ZV0HXMgt9PUFISvRlwOEQ2HCQV8u/y9PRpppNcB1TWWJIm3y7U+xknJkgMgGp76YTZtv3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMy0wNCB1bSAzOjAzIGEubS4gc2NocmllYiBTbWl0aCBKb2huOgo+IEhpISBJIG5v
dGljZWQgdGhhdCBrZXJuZWxzIHdpdGggZGlmZmVyZW50IFZNSURzIGhhdmUgZGlmZmVyZW50IEdQ
VQo+IGFkZHJlc3Mgc3BhY2VzLiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgaXMgcG9zc2libGUgZm9y
IHRoZXNlIGtlcm5lbHMgdG8KPiBydW4gY29uY3VycmVudGx5IG9uIHRoZSBzYW1lIEdQVSwgb3Ig
dGhleSBuZWVkIHRvIGJlIHNlcmlhbGl6ZWQgZXZlbgo+IHdoZW4gdGhlcmUgYXJlIGZyZWUgQ1Vz
LgoKVGhleSBjYW4gcnVuIGNvbmN1cnJlbnRseS4gVGhhdCdzIHRoZSBwb2ludCBvZiBoYXZpbmcg
bXVsdGlwbGUgVk1JRHMgaW4KdGhlIGZpcnN0IHBsYWNlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
