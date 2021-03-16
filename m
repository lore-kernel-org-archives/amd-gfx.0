Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F00C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A8A65001
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A8A65001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA08891A8;
	Tue, 16 Mar 2021 08:43:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DC7891A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 08:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avICleFWRMwwZ8rwzucHkLuZgIAnV+1PQrcElcZMuuIbgRP6NAv6yJ6bYHAN7IvKKohrfEJgUP/oOiOy6tjiyHlgDISRi1rr6ujupT6IeGshiC2slg/5677tPtEWY9bMin5DP4tB8f4HB6Y9HxEM2nxRmAILt6WO1TXEG1R5mgYJiw8Izgto3OPC81ZYdqlEZov58gWiIC2WlYxEqFdDuXeIMNdFL+WqSvV4FUzJbai0Z+cUPKZnlnN70MsIOqFSrGgR6LV0gP0gpDv6It1LeBCkunym8aAoZPbrWwoCK2Oz7WUvOf5HxeS5kj1HOjn/1zHe7eqDoRafbEpdSLkODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRMDzLOqZchi0jXAY4rPSDmFgxfDs5bN8RJ2L5Y8bbI=;
 b=C5/bXBtx+YiGwRtbwsa3uJncIsHyL7SxAZKbtTWc+wM1ccK14e/xZYDodIlwylVnKnM60bFetCmGovB9bqn0N1yarZ4jqdW41qhzejfcceSxG6Aav8JmQpOJTQkWfJv6el2FIRvYALAFP0eHhqYzH61l4Ks+SU9p2ZKEEcrAzMx2mXrLUfr81s+y8nz+xbGsMAyn0arIYQa9RG7YDRe96ehpbmABFjJaAczH+yAZT26xrEbNHVIPM2bc7FwOTBOw3EV7yEgefbW6YGK3KjkMsW2LbOpLAkhcdpPVYtMeVRIjY8GyK9y1fCdY3WZOU8/EeAJnuwDkJtyox/m2DqY8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRMDzLOqZchi0jXAY4rPSDmFgxfDs5bN8RJ2L5Y8bbI=;
 b=oi1HR8ZkfmAHysTbd8V1cOtCVrCAuCOrlnBTBLFg9SeE0mzOKJ6LhPDr3bwbIY3NlHtLDzLd/bW5OaKcid9SiHlaPI205BZuYtKqKYpZg+40ie4P0V+Wh/9QPXn1nif7mF8vcmzBp8+wF2QIi4Qw0DrGmdaY2u5LiEXh5g+flNE=
Received: from MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 16 Mar
 2021 08:43:13 +0000
Received: from MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3]) by MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:43:13 +0000
From: "Liang, Liang (Leo)" <Liang.Liang@amd.com>
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAIipgAAAPKqgAAXm64wAAqTxoAACeBtgABjC4WAABfyzTAADUrQAAACW6IwAAFkAQAAABiCsA==
Date: Tue, 16 Mar 2021 08:43:12 +0000
Message-ID: <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
In-Reply-To: <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-16T08:43:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bfeb382b-4643-4f8f-937a-f2f509970b36;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 465d07be-3e14-46fb-ba5e-08d8e8578900
x-ms-traffictypediagnostic: MW2PR12MB2569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB25691C28A886594F50644F6FF36B9@MW2PR12MB2569.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZ2OrcYoz7oOD7DUbO2mEI6w8Xczh5UHIz6J+XNzobwiSr4tU5rtqe4v1WSazoWs7WNjXYNmQKOGKypOFCXY7PkUYoBrRa9vmo5Ti4/eOuT6uGV+ylfAszUD7ndIouLmjsLKC+AZjKCJJpoBpqii9rkQzl9lzklbgDFnsJaIRGfbswdJlw+q1MCKPx+/G2IhV2KeaW2CekqTVT5s0asPwcHZxstN/FnRDBrqG/s2861ZdoDKBcGZsmDaeDDatMn+bkaVL16M19ZBY5E3jLghQRsQWtDzzIHyC/1I7qMJ305xGCZqk0AV5EjEHjX8SMOBnpLv2Tf4qzDW9x+3IVpyH370pwnhfYUJMNTi+lEz22BEoYKq8hvLs6kzuxLXkaKJmSrY+7dKby9Zt+dwXIqYiPqp1f2Nt/pfhA5lHJPVFG4V6Ot7ZeRVGaAG1i7CD3booMnnrKxiAPpPe8Aohghfdw794O19tiO/ykMV+AM8fR8h+LD2juZqGCiH2Jfo2KxF5Gl0dC6yIJdgXXA9PDpgAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4537.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(76116006)(52536014)(6506007)(9686003)(7696005)(2906002)(64756008)(66556008)(53546011)(33656002)(26005)(71200400001)(478600001)(316002)(8676002)(66446008)(110136005)(66946007)(54906003)(55016002)(8936002)(83380400001)(186003)(5660300002)(66476007)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0pDcXE5Rm5YamVSbjV6S3U1d0V5Y053SGx1NGFnd0tvMzhMWU9KZkJ6ODJQ?=
 =?utf-8?B?MmFZNDdVV1ppdUZtNU9jdU1PQVU2cHBlMGhBKzRXd0NKQjltWDhPOS82ZFRk?=
 =?utf-8?B?bEg3WE1wcU16VVZrdFlKWkpUZ3NIRHJwRG9JU3BoVFNiUCtIajhkOTBxSjh4?=
 =?utf-8?B?Vy81VWJNNE1aVTRmL29wWFA5WDNaUUtzTHlpTStjWi9MUi9mQWhHR2pybFVL?=
 =?utf-8?B?VVBKSmV6Wm9jMUp5UGVBVm1Sa2c4M3BiNnkveTR0K2gvRmJjQm5LMXUxRTdK?=
 =?utf-8?B?QldLcWNCQmlaN1VxVGRVNVRZeVErZzVvK1VvN3pFYVlGdTBmUGJSa3R0N0dj?=
 =?utf-8?B?OGRlWVRqZjh3NUJ4T0tUeSs3TGF4eVMvbGFEMjVKek5MdWZSci9LK0Q4SHhP?=
 =?utf-8?B?Q1BhbjBVazdBc3VvTU5qRldGRnlIdWRPcjh4ZU1HekszejBmQk9pSWdDcXY2?=
 =?utf-8?B?VVF3TW5qOE5odEZKeVRhd2UvVWdOK05EQlFwaGdUN2lYMDdKQjYxRXBkaVFM?=
 =?utf-8?B?dnFubmdtU1RsaUpxc0src0JiY0ZOdWJhSW1yOUx5VTBKalpZRGgySnRXNEVZ?=
 =?utf-8?B?Z29WVHlveTJXWGFtUE4vdjlTSTgxUFN3R2YvUnAwWG9UdzVJWEtQa1FkU0xC?=
 =?utf-8?B?cUVOMDh2aWVJNWtLWTJrUlRyMDVmWWNnTnFTek1Kc1NjRTVqbVdaNzhLTjFo?=
 =?utf-8?B?UlF3WVFmWmVKS2djQmZncHJ4TC9FZ2owaVNLSUFHWVBZYWtmaTZSV1ZGNThw?=
 =?utf-8?B?aGx6S3VZZC8xbnV4QTFmelEyK1djTlhaZS91ZGFXVHRmd1gySFRMem9Sakxw?=
 =?utf-8?B?bTdTQnQ1UTFZM2J5TE8zL1ZpUGd1blNvZW1TSTV3S09YbGdOQ2xQU3o2RzFN?=
 =?utf-8?B?ajVNK3p6NW11TUJlUTZyQWJpS0I4bFdYU3BYQUhqWGorUFRPZnNpR0lVTHBp?=
 =?utf-8?B?OExqMFFsLzZlWEduWStHSElId09UWkJsSFV3VVlHMXdlc0dGZ2NnS2V6VFpI?=
 =?utf-8?B?Y0hlellTTEZWRWFiR3l6SHZ0M2tsMjBNaDBuYU9TWktzSEtKRDdmeXFWY0lv?=
 =?utf-8?B?S0ZFa0NzTVc4SE9mMTk2Y2VzbGhrRENLanFKS05FM25nY05mUVdPOUE2Zmxr?=
 =?utf-8?B?Q2RqZGc1UFhPQURxbnJlZ1gyOS9QaFNwWVhpazZaNzl6NGc5WDlPU05ZSHk5?=
 =?utf-8?B?OWM2M2haaVZDR1FSSkFvUStQWWVFSWxEM2Y0VlFQUjNxMUdiV0VvcUhURjlU?=
 =?utf-8?B?akZ1VVgrYWd0SGlndEY5ZFlKOGdzdU9abGxZYldTQTJFaGk5UVZmUFcwZzFL?=
 =?utf-8?B?WnVGRFZmSkVneE82VTdCRkgrcVhrb1d2K3FNTzViSSt1NFRKMWJMYXRsd2FX?=
 =?utf-8?B?Ky9PYkNyRlcwSWV6VlRwU1J1UEJza2FEU0RKYTBqelNUSXJncG9YOFpTOEt5?=
 =?utf-8?B?RWNMRlpUck02Mmp0anFOQVV3bFZqcVVKcXU1V051OHJURkJ5d3RxS09rdCsw?=
 =?utf-8?B?eCt5cXhGZVlHUFFzSWhoSUthZnFpWXM1dGZsWlkvUWdlOEMrZ2FjdTFSZkpi?=
 =?utf-8?B?a2pReE5JUnFjNWNwWW8wL0lrdzN2VjIza0YwRWtueG1ZZkx1djlYL0N2cFZU?=
 =?utf-8?B?c1pZQk5vTTZkUC9DRUp2ay9iUFhWR01YVHZpbXZmK09EVldBQ244UHIwekFa?=
 =?utf-8?B?bkhmcnYzYm9xMDRMR0RPNm1uS0tpODZvdkhMbitSTk5MT2ZUUW1tMS9ZMFlq?=
 =?utf-8?Q?8lchv8TwP95FBHssnbT6X0qbJLWEW72IGRdpO75?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4537.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465d07be-3e14-46fb-ba5e-08d8e8578900
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:43:13.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CMSijfVFsqSHvo91XTyxIZ3SdNdzu54IBRMqShDhiqogYeZYmtHYE/1rumO4XpMfeg5AR9GiHxs3/6z0GlNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi David,

Thanks for your explanation. We saw slow boot issue on our farm/QA's machines and mine. All of machines are same SoC/board.

BRs,
Leo
-----Original Message-----
From: David Hildenbrand <david@redhat.com> 
Sent: Tuesday, March 16, 2021 4:38 PM
To: Liang, Liang (Leo) <Liang.Liang@amd.com>; Mike Rapoport <rppt@linux.ibm.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>; Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail in __free_pages_core()")

On 16.03.21 09:00, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi Mike,
> 
> Thanks for help. The patch works for me and boot time back to normal. So it's a fix, or just WA?

Hi Leo,

excluding up to 16 MiB of memory on every system just because that single platform is weird is not acceptable.

I think we have to figure out

a) why that memory is so special. This is weird.
b) why the platform doesn't indicate it in a special way. Why is it ordinary system RAM but still *that* slow?
c) how we can reliably identify such memory and exclude it.

I'll have a peek at the memory layout of that machine from boot logs next to figure out if we can answer any of these questions.

Just to verify: this does happen on multiple machines, not just a single one? (i.e., we're not dealing with faulty RAM)

--
Thanks,

David / dhildenb
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
