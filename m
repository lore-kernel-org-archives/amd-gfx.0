Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D1FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 17:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AEF61407
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 17:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AEF61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2856F585;
	Fri, 30 Apr 2021 17:45:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 314626F585
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 17:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtCSuy4OCU0uEqL2mOLWSQDmNbEI3TjGz7+dwCVIlxLyJ019V2qZyJohdioaaKxM62fFbLskufPTtxvbNKDQOA8xy/ZFMIopcwrDlpKFk47xIKFctPEoaYm/O3Hgj4ep0PSvafNlMCq+Rgi0K8eSeABnr1x0HqTcChSco+gyyfD4MrH5jDrpqRI6X+wuBAGgv0CpTbDs1IUNyzVy8dd3SoppSIwpAFuyWPlLzwRN6JiRqUp4+RIgQc867u+opyGiHWL7tIeFw80j84St/ztY3eB47CF6svVgXBK/ef+01LbQ8TdmpOvd8Yu7QsVYKc4zlT+RF2++m3nuTSeWjgbEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIvMPgTKyuAam6JaldCQelyHdDpwBOsUO5dcwY0MSho=;
 b=Dv6htwiTpSDiVq9j5YNbnzTydMsX1AECqK1EuAdEUY7t/fFV3tU78AoUMTrSh0oh/P0OFVXnReFcLXHirQRrADL3w1Lyzb+KnFe4zP6f8Eqi/IWUT4A9enRjbrjsxU6ZG7bo4XsXUjtqU09CMxZosuo5fn6n3VV3vM9yTsp/LqnxN9acizeUYy8mjJ+4NDoR9BrzFiNeMvDtsJ+S3CAUiBUut+LqsrfTod3WNj8ns5BrmpvBXve1v9HbpNjCMhMQrhaumYTiQKNA1/IVT+y33vbNT8Z6Wvh8CKDkmIYQ6ckNB2FmiHRVa6nxvpa4o6u/FISXy//EJHUrSp6Rsmuy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIvMPgTKyuAam6JaldCQelyHdDpwBOsUO5dcwY0MSho=;
 b=DmyCQGaBR0OR+RzTHpVPwWbOkhzxsp1AgN8Dj+R+obE53g0Qg/x8kNhwygfnFywQcCwNFuHx8cnD7F7CnhyVz6zEFYuAmJsmEr2kSNPQ20PsLqseS/AZp9DfOo7sS8+7XRa9/337bDUe+r3I+ZEOGU2fOxXG4NChdkHI4Me3W40=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 17:45:21 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 17:45:21 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210429183351.17914-1-zhigang.luo@amd.com>
 <a8683018-e0db-579a-943d-d4e08b053654@amd.com>
 <DM6PR12MB330837936F1191BCE7FD835BF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <308e66f8-9847-8910-1b6b-7c6ca662c70d@amd.com>
Date: Fri, 30 Apr 2021 13:45:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM6PR12MB330837936F1191BCE7FD835BF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 17:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef19b220-6f3e-4aba-a0da-08d90bffb9f4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4207F7FDA6E79D765DE80584925E9@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsCIm1DHyW22VxikPKUOECoR0xo7AKOzAiIqj99xS7RF+mUCLfXIwBoD6aMxC/xJUmA1t2JsFZmc5DOqUcFfcpKH+dPMpiAWcGw46O6ArTNCLw57VV11cOZGSwoqGvdqL9p8X/47zR5UwzITwI0kTEhbk7BN+LNYR7+zANCIYuHoNyElASc7ewJmbXuAhBLfmoaaFh17/CtkgvBrVsRZn5USsvG0JGwAM4VHZUrV4oP7dY/CVXiV3IKI5DLHEznHmbfdi/y143Db78j2RZlB6A3aZToatoCkO5Mqfz1rnW88Fh2Zr1fWpi15fLe3fuL5UghErZEDWYXm4A09gTgVG6Z0wq7TKoJDl3GwK5tZqAheKiGTfnGWAzxtsBPFDI+MBUSUae2NWZh/Os7Hx8UmNjo23LIj6hRWLzmJUhQ06jYR9BMgsA87QH/ywWNJqp1AKZlsOi/usOcRIKm/z3SM6wwdpOKGb3ErilAqEtXT77GlPAEUep4wd0w+mePEULjKqfJxMyI9RDki4nzH/nb41CAU+qn1werLKVDj+Xvw38prpLVwAuDri7CfGZ75Fiqc2yAZB4Rsc6Bt4xi2igAUItxEpkfJf+9C7b7EPUHOsFr42Zb90i1Azw5+NCgasD2jUONzPY1rc3n5QSRK83aYN4S+nIcgYYaYqfvvnzkjW2ly4b+qLbHe78a+t0q85hAruRmPdCXV2K0O0s7hIsMMVvDzaMlSNJDg+wfMqnKns12bW2gqu5VQhZvo+tQAcBqDH4X/U+d+tR7huVyZDi99QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(26005)(2616005)(66946007)(31686004)(53546011)(66476007)(966005)(44832011)(5660300002)(186003)(956004)(31696002)(83380400001)(38100700002)(86362001)(36756003)(2906002)(316002)(478600001)(110136005)(8936002)(8676002)(16576012)(66556008)(16526019)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHdMcGFIZXcxTU9WTWJ4Vzh5QXYxSUtwZlBnOGFwdnNzRVJzcXNVUzg2VXhw?=
 =?utf-8?B?dFpoTCtlQ1ordzZlTlVTZXJXdzJtbkkvZ0UxS0p0WVcrdDl0M01oR3B5SWZj?=
 =?utf-8?B?QUJFTDd6NXJaT3RTUk9qUThZOE5LV2FRRHEzRUlkZjlnbFhkZFhoRFNkSXl1?=
 =?utf-8?B?am9wTEpScmZSSFR4L0Z4d1hBMExNK05FZzE1bXdSV0FaU2hnWENkUm5kcytL?=
 =?utf-8?B?NFIwa0VOQnl6cEtnSVo1UDBnN1V4K054RlNaZTdzSzFod1I5NXJKNHBWcGVh?=
 =?utf-8?B?eXNITnJmUnlnektIMm96eCt4TEgwdjR4UTMrcFFTUVUwQ0hXVmpXQndqU1NB?=
 =?utf-8?B?ZGN6WWdUSHNIVDEvNHdIYnRYVWJRd2hkV3U3V2plTWptT3JiQW05SVFzNUo0?=
 =?utf-8?B?RnNsKy9MVDREZ2JtTERlNWk4U0lhbjZuQ0NPUnk1a3dveUNDa092Q0JZYWZZ?=
 =?utf-8?B?enQ2aXJqaHN5aGE1Zm9jdFppVGZud2pNcERrWWJPNmJsRzRlNFBLbzF0VjN4?=
 =?utf-8?B?M3hIcVdreDkxZkhEOC94MlNQQ2FpT2M5dCtBZ1NPdmFDVE8zTVVERmJoUVRr?=
 =?utf-8?B?Tm9MYnFlTU15WHRvUFRoUHhsZWp0UmZZSGNDSVpTdFl1OFRQNjE0anRISE4r?=
 =?utf-8?B?cGV1cE53MTl1TnFQQWJNb3k4cUJZYWtyWERQRCtxZk1wSVhTM09GSmphZ2FM?=
 =?utf-8?B?S0pjTHh3eE1zTFVEZUtiNEtseXZucE9VTlJjbmJTS2w0a0pKSHE1OEw3bGdP?=
 =?utf-8?B?T0hTQjEyUEtkK2poVnR6SHN4WW9zT0dpSW1JK0MzaHNENFA4ZngrcDJDRHow?=
 =?utf-8?B?by9ZRWJFRmtHQ2NKSi81dzIyK2UwMkgzUkV6dk05VWNoMkJ5Y3Y5VGJRcUp4?=
 =?utf-8?B?NERMM3l0OGVWY1V0WlpsSDcvUm1yc1dFc3Y2SEFydXBqSGhqRXJqenVDWEQ3?=
 =?utf-8?B?KzN4VWNtQWZFbjhrZ2lYbFFPL1JpdzZSWllPRFBsS1ZWSUZlcWU1eDIyV1FE?=
 =?utf-8?B?cGwrUU9nWFZyMTBhMDBlYklkZnNqYzRrekRrUldTMEdCeHRtRGpJNU0wVVpm?=
 =?utf-8?B?M1JIWDRpbUh0a1FoelZZSWNyeDMrVy8vbEcvM0g1a1pDeEdnWlFKUWtMTlRS?=
 =?utf-8?B?Y2dOUEE0RkQ0WW5kUENwYU1VMm5lZHJWYndIQ0NPWlB4eVRad2NDdWVUbzMx?=
 =?utf-8?B?TDd4TnJxMkd5dHY2S1hwQitJaUdieTBMQ3paaVdDYlAyWHFWc3prbDBrVGky?=
 =?utf-8?B?eDZUMzVBTWxwa3Q4NFFsNnhJRVh1T3lGVXNGSnR5eE5jdTVWTmlNV2F4MkhK?=
 =?utf-8?B?NDFTR3JFdUFQdmxZYjE0L0VaeWZmTTBxVnU0dTJnb2Mxa0JoMnUyOTBuNmov?=
 =?utf-8?B?V3RmN0kvdzJ1Vm9SMGVUMmdxaDBiWFluemFIZXZsRWhrbGVoUlk2UWtMUXJS?=
 =?utf-8?B?bXRqZmhsNEZwbkd6U092T2xsQXdtVG1tVmlnYTZrRFZXRVE5RW5pcU83QnBI?=
 =?utf-8?B?SVhuRDVHQTJleTJJTnRZRXk2cTRlS3AzWFpaVC8vVEhYYlpmVmEvVi9QdFly?=
 =?utf-8?B?OTRLZy9LNjY1aldUU1V1VVRyaFVielBocHFxKzZyZFlJcld4U0d4SWlVNnNq?=
 =?utf-8?B?UlhpdDRybS81RkhuSUFBdW5HTXo3QmFYWFBGbVVkUGdKeUdMSUc5M2tTOW1Q?=
 =?utf-8?B?TnlQVThtallPaDBkNXNKNkpPajdOcHRXNHlKWDJENzBRM0RwUFNZNm5MZjdl?=
 =?utf-8?Q?7LasdCbyn3Vx/WpWlfRcAYX7Z0DHJ8XKjvtfCUG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef19b220-6f3e-4aba-a0da-08d90bffb9f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 17:45:21.5980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEvXV+pw0yCIsFg9BRwkWc7BJ9VFhkCprBZuWZgaVsrRySry+Zxyi2cO+kCJdczOjp/mbyy3LdDDp0dFwk7d4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

SXQganVzdCB0b29rIG1lIHR3byBtaW51dGVzIHRvIGRvIHRoaXMgbXlzZWxmLiBUaGUgY29tbWl0
IGlzIHVwIGZvcgpyZXZpZXcgb24gR2Vycml0OgpodHRwOi8vZ2Vycml0LWdpdC5hbWQuY29tL2Mv
Y29tcHV0ZS9lYy9saWJoc2FrbXQvKy81MTg1NzMuIFBsZWFzZSByZXZpZXcKYW5kIHRlc3QgdGhp
cy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKQW0gMjAyMS0wNC0yOSB1bSAyOjQ2IHAubS4gc2Nocmll
YiBMdW8sIFpoaWdhbmc6Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQo+Cj4gVGhhbmtzLCBGZWxpeC4KPiBZZXMsIEkgd2lsbCBzZW50IG91dCBz
ZXZlcmFsIHBhdGNoZXMgZm9yIEFsZGViYXJhbiB2aXJ0dWFsaXphdGlvbiBzdXBwb3J0IHNvb24u
Cj4KPiBUaGFua3MsCj4gWmhpZ2FuZwo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBG
cm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gU2VudDogQXBy
aWwgMjksIDIwMjEgMjo0MCBQTQo+IFRvOiBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8xXSBkcm0vYW1kZ3B1OiBBZGQgYSBuZXcgZGV2aWNlIElEIGZvciBBbGRlYmFyYW4KPgo+IEFt
IDIwMjEtMDQtMjkgdW0gMjozMyBwLm0uIHNjaHJpZWIgWmhpZ2FuZyBMdW86Cj4+IEl0IGlzIEFs
ZGViYXJhbiBWRiBkZXZpY2UgSUQsIGZvciB2aXJ0dWFsaXphdGlvbiBzdXBwb3J0Lgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGlnYW5nIEx1byA8emhpZ2FuZy5sdW9AYW1kLmNvbT4KPiBUaGlzIHBh
dGNoIGxvb2tzIGdvb2QgdG8gbWUuCj4KPiBBY2tlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+Cj4KPiBJIGJlbGlldmUgeW91J2xsIGFsc28gbmVlZCB0byBhZGQg
YW4gZW50cnkgZm9yIHRoZSBWRiBpbiBrZmRfc3VwcG9ydGVkX2RldmljZXMgaW4ga2ZkX2Rldmlj
ZS5jLgo+Cj4gUmVnYXJkcywKPiAgIEZlbGl4Cj4KPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDEgKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMK
Pj4gaW5kZXggMDM2OWQzNTMyYmYwLi4zMTBlMTI0OWU2NGUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gQEAgLTExODYsNiArMTE4Niw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lpZGxpc3RbXSA9IHsKPj4gIHsweDEwMDIs
IDB4NzQwOCwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9BTERFQkFSQU58QU1E
X0VYUF9IV19TVVBQT1JUfSwKPj4gIHsweDEwMDIsIDB4NzQwQywgUENJX0FOWV9JRCwgUENJX0FO
WV9JRCwgMCwgMCwgQ0hJUF9BTERFQkFSQU58QU1EX0VYUF9IV19TVVBQT1JUfSwKPj4gIHsweDEw
MDIsIDB4NzQwRiwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwKPj4gQ0hJUF9BTERFQkFS
QU58QU1EX0VYUF9IV19TVVBQT1JUfSwKPj4gK3sweDEwMDIsIDB4NzQxMCwgUENJX0FOWV9JRCwg
UENJX0FOWV9JRCwgMCwgMCwKPj4gK0NISVBfQUxERUJBUkFOfEFNRF9FWFBfSFdfU1VQUE9SVH0s
Cj4+Cj4+ICB7MCwgMCwgMH0KPj4gIH07Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
