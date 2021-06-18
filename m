Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A06C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F5461279
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F5461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD15B6EAB3;
	Fri, 18 Jun 2021 21:48:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A06C6EAB2;
 Fri, 18 Jun 2021 21:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOwE+2RV/goNu5pVRG9UBrX4ucPiApJVqHdnYxJ50FRmF4SaPs/Cq/BL/R1ERzD63qcYZovMlbZz4GP2apuBiT8DniS2VWkB8+vPrMSwNDgicfkBuAfPtUXh7HJpr8KIMxTpdpqiQTg3IrC8oRppTKcYZJuWsgb69OksXBbYGBYPAAR/Zu8mqsGV1wMtPV2TzugEnRsZefugbqaR4uDLC95066P6U28nAIbpZAc3GBm5X1UVZHTHCK20kRuLNTunFCgj2vn/FxZ5fWc6dytJ1B5rnGeITeT6QUgJrBecdKIh2XnNTgUDY49/X6ilfi0rdeJXD84r+h4W3tSKvvg7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn1HUybjysrXXMnY7Zfbr53vXDj7cmXX7m8oZxFG8u8=;
 b=Kmt8Z4M0mO0jm4ugXcWdqhIqLNcTw2VGek0BrqTRQ3AGH2kVcHCbNs8whAGpJpxeDdfA73tSPQytHTnkGltFInqNzhsLdhTV3EDYQ/wk4gsrNmOHS0HCYo1qqcG7Db1wVrAnPE9yLHej4IzqW5MDWZ8d6ZBh2OxM1IXQFwsYAYy6jGAsVc3p18ctUXo50g0I8qvK810VxPx3iTvtCI/A6R1EgR/mCA0BSbwEGvv8/aqguGUtbNu0ZSYyy5PHUPlskLRSOovqgzEVz5fVeemgoaDrYToJXOdPuHG2Gp+TPnhC+MlqIaFsl6fOcBeFeJiui9tMnXw0DJ6nZ7ua7QCryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn1HUybjysrXXMnY7Zfbr53vXDj7cmXX7m8oZxFG8u8=;
 b=vEJxDuKrcN47hrI/jJYcJVf0yhh4yVSFBxUTUBRErN8Q6iVDMtozYCT6vuT0PB2mXiVREvzX7I7jSbgMe5AmVEqIKNDkPJ/L6DciqFi3ysN2fduTUhblrrRPzo7euzVLkjBvxmqzo2GfkN0fC3wWv3QGRvUeDBCOQsthG/mFwHg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 21:48:35 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 21:48:35 +0000
Subject: Re: [RFC] CRIU support for ROCm
To: Adrian Reber <adrian@lisas.de>
References: <9245171d-ecc9-1bdf-3ecd-cf776dc17855@amd.com>
 <YI2J97Rg4+1+KVNs@lisas.de>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e6a70c3c-c710-5566-4152-876324ddeb73@amd.com>
Date: Fri, 18 Jun 2021 17:48:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YI2J97Rg4+1+KVNs@lisas.de>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::42) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Fri, 18 Jun 2021 21:48:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d2504b-6043-41f3-fe1e-08d932a2d2cb
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5195061A3161102F915BD0D0920D9@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0NVeH4RgtFLaevxNxYtMQp+r9EKdA2UvUzY8jdjYAtPhz1hoYMgnWhE2mAJM/6dMp0ZJw2YJyT7z/hBpfgCD0EWtVM/dMCTDtIpLkVPmc3Poi1D67TG4HdZTXSX1rRp4UD45V8SLtjNYwpM8S1lC76o00/Mzw1THsAmKful5NUaj5trU/LFDJTRLgSzSrrZlUwsbgJJZi0RNUuWsTjGCJcUAyIcRuZqxWsu2kk6fwtzvpgiG3qnm3lqlOs+hTz0j8Rh5sL2NoHQZ5lLbEYawA5WFJiEGPdpHQadxQ+T82AF5xskBO8LWpDtGoewXWqyg2nk65NDnAKI7soClCgXqOStuGfCE2MlsJpWvLRS4YmAjAC4oHPeN1QUk6EmBr58QOqQXKAivH7YxfJPVRp2985ilKP/i0YCL/QnFQwA0QEF4+oGXm5OrR1SkBklmzqz+RpwIhbMxdsYKiNEaTqIZur8Px+9y9ds64dL2tivkczDVeWzXU/Cl5FqSmjXps26k4PKogZ10K09tqqKutneiTafwrD9fSk+t3ktxEq4TFG6RO6dSp20Q3VGKQJ9I2XUE84JUuEGkTCoZfhWb7w26t3UBCzqcdQc2xhni9VaUaXdN3Zp2a+bjxUSGU5Zx8jjjzflh3dUENecRFsogcMTq8o4dgXS2sbS9R77zyvJyZxcZ7r1+yzEgrTUHge0kzCbg+LGxc+W7v1r4MD1qOZJBhIVg576eiYJPF5HeucPeMx9PrGKm2U9SUiGyGy/XGk37VGpOXKZDGjQlQVHyz2Z0y3Dd1LEF+a57NvD07c4fgBODph2z+QZlgkAFOcMmRZc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(38100700002)(31686004)(6916009)(5660300002)(6486002)(44832011)(66476007)(16576012)(31696002)(316002)(54906003)(4744005)(66556008)(8936002)(86362001)(4326008)(478600001)(83380400001)(16526019)(2906002)(956004)(26005)(36756003)(186003)(966005)(2616005)(8676002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZydXRMUGNJOE1mbkFHcFczSG51akdoYUFuTm9JKzQrNWpNYzRqQytaL2cx?=
 =?utf-8?B?K21QenZTbTA0UW1qTzE4Wk1YbmJMdUs1L1VQb3NLSE56a3N3Z21KSjRaVDNh?=
 =?utf-8?B?VzlrRVNCeFdVSjkxYkpFU1NaaTZFNFA2T25hNUx1bnIxWENncGJNSExRM09F?=
 =?utf-8?B?ZTV5TVlJOGYwSUhQQlpOSnk1Z3VPT2FSRkxDaDFjT01hVDZJZEVWbGY5VFNF?=
 =?utf-8?B?YU9iZStKdjJKVDl3amdlKzdyQy9nOGZQbEowUUpINUExSS9yMytHUlA1eENW?=
 =?utf-8?B?TjMrNDk4dk9oUS9jVkFUWVBvSW9CQmRoSmpjSXRNUkRpRVdmb3lJbExXRlhn?=
 =?utf-8?B?enZnNnNMNmhYUkFlOEN2a2NFNzYyM1crNGNRRFNSaG5naVllZUkxQ21ib1JJ?=
 =?utf-8?B?Y2c1Q2NRMmo1U1g1M0x0Q1UyY1BVSitxVEhDLzB4aEtha09jaXJNQ3JZWkY0?=
 =?utf-8?B?bTFBRHR1M010T2NBdk0xY1MydysvT2tXZ0QrS0dQNjkybG1Ma3hnMkVPNTNj?=
 =?utf-8?B?QzAzMFRzekdoaUdxYkMrdDE0bHpsN0VBMjArckJDeEtUdFU0dWgrNFJ4RlZE?=
 =?utf-8?B?KzM4YUhxZWFtSG02cWt2em5SUTFhR0FqL2p5S2hkRThwQm94RVpPL3ZhTmdr?=
 =?utf-8?B?OGVOZC9xd0J2UkRhUmgzQis4RWtEd3VaM2xsTjdlOVVZR1lLRnhZT1A5Vk1L?=
 =?utf-8?B?dDB2UjZ3OU03enhEVXZZR3NleHNWQnZrUC9tQ3ZKYXZxcG1uUXFGc0dVSlgv?=
 =?utf-8?B?U29wZGxMRXBlaWMrVm1oV1V5cUR0c3NKYlNuUVlWT1JCYVJqcGprSE83V09x?=
 =?utf-8?B?Zm56akpZVXNaelVZVklkN2tkdFM0UGNpd1FQR0NtL2dxajF5SHJ3SDgvcE5I?=
 =?utf-8?B?VW9QakZ2M0RUdElrRy9xc010SU5obkZmdmpHbTByQnZEckpUNk9WMTNwR3dF?=
 =?utf-8?B?UlNYd2RFMHRHd0dVcG9DaS8wQzk0a2ZiVFBjMTVQb01rc0g4VGUvTlpCRm5j?=
 =?utf-8?B?RjcwNkE4QWJpZ096Y1FxbzBJdlA3emtHdVltSEhMRmk5anBGbGhnZDJKaTV0?=
 =?utf-8?B?dU9SUnR3eWVWVGs1aFJoU2Q2cjQ3Q2hnMDhZWlJUOUhFcEcvMzl6NXRUd1dF?=
 =?utf-8?B?bnNqbGRGR0RHMWI2UXNEZUdXSTVJUzdZMHJOREcvWE00QzdZWVFXdlF4V29O?=
 =?utf-8?B?aE9VMURWb3VWRUsrYy9BeDUvbDFac1NkSlA0SzBpZDdaMjFYV1ZibXRlcWhl?=
 =?utf-8?B?TUJKNVVBTENPcFhaVk9mWGwzU29OcmRGMzRVNEJqYTRWdmNsV29UWFd2Ympv?=
 =?utf-8?B?RGYxWFEzKzNDZ0MrSHJGUnZWR2RnMURLVnNxTGRFdXpTVTM2SlBVSk1KU2Zn?=
 =?utf-8?B?RDAvRFJDTFFCeUJRNmpVVG9uY1J5c0NiMmZDZDAyU3licG5GSjkzdDNwYzlO?=
 =?utf-8?B?TnozSHdMd3ZjditlTDBzaDcxRmphNkVVb1ZtL05OSG5tN2laQkJRUmhMQjBv?=
 =?utf-8?B?NmcwMmgyUnAyd2JvK1hhTUgvY3gyd0YwZHdRTFU3S0JmcDgwMkVKT21XbTZO?=
 =?utf-8?B?MnUyWHloa00vNi9tMU0vQTh1aGpkcHl0aWh2dkZEdmRrSy91QWcxeHMxMytJ?=
 =?utf-8?B?WmJ0NG5iZFJwWHJaK1BvcHEvdDZMbnIzclFkR1BPdjMxakxMMVJGOXZvTVBt?=
 =?utf-8?B?a3RSM0tSdUtqUHowWDB0QkZWanFNTnRDS0xmTHB5WkgxU1p0RERCdC9YQ0Z0?=
 =?utf-8?Q?8Yt/t8zsx7HaAaLyWDnZQXMV8tQAhxua0P1a5Nn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d2504b-6043-41f3-fe1e-08d932a2d2cb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 21:48:35.6094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12PBDw/zbRwdAlV71tcIHGwN10XwGVNpp29KuQBNIs2/GqsFY6VGbEFqZ0IQtlMov4ztLlkLuvvMrub/IjL7aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
Cc: Alexander Mihalicyn <alexander@mihalicyn.com>,
 Pavel Emelyanov <ovzxemul@gmail.com>, Pavel Tikhomirov <snorcht@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, criu@openvz.org, "Yat Sin,
 David" <David.YatSin@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0wMSB1bSAxOjAzIHAubS4gc2NocmllYiBBZHJpYW4gUmViZXI6Cj4KPiBJdCB3
b3VsZCBhbHNvIGJlIGdvb2QgdG8gaGF2ZSB5b3VyIHBhdGNoc2V0IHN1Ym1pdHRlZCBhcyBhIFBS
IG9uIGdpdGh1Ygo+IHRvIGhhdmUgb3VyIG5vcm1hbCBDSSB0ZXN0IGNvdmVyYWdlIG9mIHRoZSBj
aGFuZ2VzLgoKSGkgQWRyaWFuLAoKV2UgbW92ZWQgb3VyIHdvcmsgdG8gYSBuZXcgZ2l0aHViIHJl
cG9zaXRvcnkgdGhhdCBpcyBhIGZvcmsgb2YKY2hlY2twb2ludC1yZXN0b3JlL2NyaXUgc28gdGhh
dCB3ZSBjb3VsZCBzZW5kIGEgcHVsbCByZXF1ZXN0OgpodHRwczovL2dpdGh1Yi5jb20vY2hlY2tw
b2ludC1yZXN0b3JlL2NyaXUvcHVsbC8xNTE5LiBUaGlzIGlzIHN0aWxsIGFuClJGQy4gSXQgaGFz
IHNvbWUgdXBkYXRlcyB0aGF0IFJham5lZXNoIGV4cGxhaW5lZCBpbiB0aGUgcHVsbCByZXF1ZXN0
LgpUd28gYmlnIHRoaW5ncyBzdGlsbCBtaXNzaW5nIHRoYXQgd2UgYXJlIHdvcmtpbmcgb24gbm93
IGFyZToKCiAgKiBOZXcgaW9jdGwgQVBJIHRvIG1ha2UgaXQgbWFpbnRhaW5hYmxlIGFuZCBleHRl
bnNpYmxlIGZvciB0aGUgZnV0dXJlCiAgKiBVc2luZyBETUEgZW5naW5lcyBmb3Igc2F2aW5nL3Jl
c3RvcmluZyBWUkFNIGNvbnRlbnRzCgpXZSBzaG91bGQgaGF2ZSBhbm90aGVyIHVwZGF0ZSB3aXRo
IHRob3NlIHR3byB0aGluZ3MgaW4gYWJvdXQgdHdvIHdlZWtzLgoKV2UnZCByZWFsbHkgYXBwcmVj
aWF0ZSBmZWVkYmFjayBvbiB0aGUgY2hhbmdlcyB3ZSBoYWQgdG8gbWFrZSB0byBjb3JlCkNSSVUs
IGFuZCB0aGUgYnVpbGQgc3lzdGVtIGNoYW5nZXMgZm9yIHRoZSBuZXcgcGx1Z2luIGRpcmVjdG9y
eS4KClRoYW5rcywKwqAgRmVsaXgKCgo+Cj4gCQlBZHJpYW4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
