Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B5C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E363610A1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E363610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42116E0AA;
	Tue, 18 May 2021 17:04:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF60D6E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 17:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flQL5y9jOGlfykYIpYD9M99lsYSQ/evUc0RfACdoVcoEkZ0RHLqFdD90sbeU5HG0jzOGtqf5odBAVJJmi3MMa0ZHuzTi+nn3P4H1FMgGi8jxXaqS/zPASzQfoOzMt7TEob8sv4HBtk7EyXAvriNyPI+ghrsdAKe3QUuK5gTCbiMh38vWTiQZKgErz4qCbRSCki5IFyWZeJptEancWIOUTisGZIWEEEfsfMQxyLfI3yqAKoTDwm8f9eA5iZILaw5WHvydR/9aV4A2WpeSgPn4IkhkcODAPxjijOQMP52QaXVsMWyj+lTXyY7zVpssSAxN402B9CTdSpKACCyaN/bYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76aqCqjHRPiryEdcurRKVB2zcuf/0YCLlui10G3kUH0=;
 b=F0yD2mRzayvv0mDvnbUBuGVfyCaX65UEtPye1vb+g0kEuEg+tXHrEqsomMOvH/gvQQMv3a5JgZxBRN7h5MxCtZE/YRjnuaNMN+lfd/IirZqWFA6Iovw3FdIn4IXuEhdfzVTbRC4zgZPROWz5thggu1kClbC0ZN7rXTvDjKkFC7DOSshTjAUvhQSmk4UIdCaiaFtIbpcCqEcylVIMtIQqk+JRA0ACGQE6Srrv6x9ju1H+ItRiLIop7ej8ZDrmWNIstsHfXnrsktqhc8fsdynQtwgv1U8quukMDIlQeOBS47X5WPVOLqZhG89gEy4R2KJovcnHYmQ1n9v2VlrclJIktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76aqCqjHRPiryEdcurRKVB2zcuf/0YCLlui10G3kUH0=;
 b=yY1G9aTVCH8tbbdcC99oSLjXm3E596OlLC68vALoWkQ2J3mo1dx2ERyaL2PC2pePpgkJF57pvmTBhz0ZBoP3pYUNNec7ootKMWlsafpJb85c8V4he6hqlG59cXaoPMB52v5EcxEPPJz5PzZ8gQx10qyPXdwxUKVh0WXVWmhClUE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Tue, 18 May 2021 17:04:56 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 17:04:56 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
 <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
 <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
 <efcc2430-836b-7fcd-71f9-b2ba45258177@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <fb1e33bf-b597-baef-b7fe-094c8128f4c5@amd.com>
Date: Tue, 18 May 2021 13:04:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <efcc2430-836b-7fcd-71f9-b2ba45258177@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 17:04:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddb146f-3301-4cdd-958c-08d91a1f0fbe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15962C399C50E8D167113C30E42C9@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhV4W3gDuMgttXO4byuK9ZMrgjtEc5mXEhgs83EwMs/J3IaAEtZnGhk8/ERfoe9yXrC+zHj/Z+xQmZAn9p0pnnTkeXCa/PFXxGbdI5Da6G7XtaIFs06Wuoppf+t0SUb5IQqdcoz5bv/AHWRWoMLQhfxngNmwK+5aw2o6UEsuWYJhsxC2a/cGNCT3kh6KWGMp/2EQzsakwyAPcqdkl3MTyZf2inVmPvmF2n5BaQYxMghZMDjUGhgOM+tY4aiigu0kwgdID7iaXzFGNZPdYPCKye1VKRMzMCKxzOy2Z/0FW45fbsMkay9ooO3zSrcdufVfxyNsreRJLhgN15f3RLfoKiV1pkD1LtDJu3z+ua+aCeeUIGPkB7EVS14SDDUw6D5g35pDUbamW+VV+2pbv/4mr82bDnXpsu+/OqMxwsiqxwzQpKyGqtWmGIYhB7PrM4S0HpLmTwp3BZtlRLlKxBNA6JkMfz5+2UweWIJOGcZ/d9XuHCoqcUdcVBnIcLK0JU5KdpnRCKdZw6tkOTwsA+JHnPXAuIi+NMCGU1xEN48YDZKlFMoZNsNU+hYZmIxgcCnMZhy8CzncJj+i35hMChHbwpVtEqE4a89lYYJF8Ayq1TB0SSkY4aDjZg9fiquIbNmrwSDBm1GwILRblWXFgJ9Oumr7q8QqHaKN++0geWgcOtErB9tf0CfOXQU++BgCaJLr/icRHNDmFBNa+2yCFJZn7oI3Uf4noTKAHPLs24o1uAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(38350700002)(26005)(83380400001)(16526019)(8936002)(66574015)(2906002)(38100700002)(186003)(36756003)(110136005)(66476007)(2616005)(316002)(52116002)(66946007)(53546011)(5660300002)(16576012)(6486002)(478600001)(956004)(31696002)(36916002)(31686004)(8676002)(66556008)(3714002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0ZlWFVGVDJ3QzFOSzVwTWVJZXVrTlNnUGtpbXhwdkt2RG0zZ0JNck1TMmFv?=
 =?utf-8?B?NzdnTkdSVXU2Qy9jcDBRUlF0dExpdDZwM0t2azlhUVloTFdibUdHZkRMNVhT?=
 =?utf-8?B?NjYweHBBbDRIVnVGYjFpNDNYOXdLNGVVUWVOenNMYUFnczFkVUJOaFBNQkdD?=
 =?utf-8?B?bDRwdGVOWVp6NUZOZG1yZTRReUV2aVYvZzhiTkVhVlA1L1laSUVUeFVvWmQ2?=
 =?utf-8?B?YU9SWnB3dHlqQkR4SUhVWmFmMHVyNHJQZUw4Q0lQQjVpbi90ekJnYkYyNnIx?=
 =?utf-8?B?RW5UWXRzbDRmVkRMcjIzaGhtSWNPS2R0UlREdEJldkxaNmNtSEQxdHVMRHJP?=
 =?utf-8?B?dTBmbmIxR3RGWG40YytEWUg1dXlnTlptMHZHNWFETVV5TzdlbmFGQUxJODM1?=
 =?utf-8?B?RnlYd20zaUZXcjAxOWw1L0pwaE9KdWVoNWprN3NFcEdydnRkSmxwWFNadHdB?=
 =?utf-8?B?d0NBcmpVMUY2V3d6elRNbUNjYVZGQnVVUXRoSEIrQ1k4OWpoM3p2WWl1TEFj?=
 =?utf-8?B?S3A2Y2wyZitKUnFzZTFXSEZZZ1Z0U2t5a1BYRW9YVnJnWWhZSW1yWi9jU1hv?=
 =?utf-8?B?czFpRlRySjUyWWJQTXRIOHR4Z3QrVzVEYy9yeFFzaDNoMnBSOEZqL0FYL3A5?=
 =?utf-8?B?U25RK2lETzU5elNSYzFKbnpsbWtLR0ZsUEhXWEtUQmZuelJQaElHL2ZIbjZT?=
 =?utf-8?B?dkp0d2VDOHpYTjJnaVhZc3kvS1RuWHZka1l3UGE5eGlUeERPL1RtT0JHRFlr?=
 =?utf-8?B?VGkyaVRGbUI1cndFdkhBWUZucmpaQUd4R2c1UmlqYy95OEhrVXM1ekt6ck5s?=
 =?utf-8?B?aE44Y0ZBanRzQVFXRUEweFVKbk0zTUt4a3ppdDR1VmczSHpPSk5rQWJudUN2?=
 =?utf-8?B?VzNWNUlrVGEvOHVFKzEzSFhhUFpFakJIU3ppaEZiVElZcENEV3pteFQxcW5w?=
 =?utf-8?B?Qy9iSVJRRUFGejhvOUR4RXpuWURqc0ZJNXl2MVA1NE1YZ2lTM0cvd0pZUHZF?=
 =?utf-8?B?UlY4YUxoVHEySkVKOUUxbEN3Mm9DY1AyaGQxYTRGYVpFOWsyckNxU0JKMTlU?=
 =?utf-8?B?clkvb2dJcTRoZnVmVFhpcnN3bTJGLzlCcXJwU1M3VVZkWlp2eXhRb2dpRzdV?=
 =?utf-8?B?UVdZU0dVRk0wcXpaWUFqbmFLOE54cStzSHl2cG5oNG1FTGdjT005cUxNUExG?=
 =?utf-8?B?UUhGZkkwaXFSV01MNFFqdTVwbFR3L0FoYWpLUzlidC90YlF0TGFycHcxcU5s?=
 =?utf-8?B?Y2Y3N2RlblpvdjV1cTZ0Z1Q1OGIwRFF5TnpMOWFMSkpyZmI3a2ZZdlpoSEx2?=
 =?utf-8?B?UGVROEpsYVk3N3l5clJSWmFIMmhDZG16bjAzQ2YrMDIwWDc5STd4ZndQQlYz?=
 =?utf-8?B?RUQycER1bWhsSmpIR2hZZzg0Ym5IVExkeXN4ZjNUZjJJS1RjclpSNjZYR21Y?=
 =?utf-8?B?L2dJQi85ZWJHQTFUYWE0Q1FPRXd0ZEk5L1pCZ2NIMVBlL2J4Qmh0MjVBZks2?=
 =?utf-8?B?VWFjOFZLNjdxUUJZc04xd1ZmRUpPamlDTENyb0l6aFcvQjZTYmY1UHhwaDBp?=
 =?utf-8?B?aWdFT2NTS3RzMVBCWXp0VjhjVW5DbXpMSmlrN3lxZURQc1dQOGZwVjV4ZEp3?=
 =?utf-8?B?UkdYbXYyU1NkcXg0U1hmYnRINEEraE5aZVlmOUQ3d0lXN25vckJ2VDZBT3Uv?=
 =?utf-8?B?aTUzVzFoTU5GanJzWUV2NVRUMDJyL0llRFkraEZJeVFLSVF4VGtDSmswL3Vh?=
 =?utf-8?Q?1CHWU7hzB8/pJgM46ulz+/6y+KH/V+BHKFZMHJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddb146f-3301-4cdd-958c-08d91a1f0fbe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:04:56.1501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AQxcDNwdMeleZ4C7qCgnPx7USgznQ3n2C/YiltJ44Yugspmm/hzBYJqHlZtlihJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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

Ck9uIDIwMjEtMDUtMTggMTI6MzYgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
OC4wNS4yMSB1bSAxNzo1OSBzY2hyaWViIEphbWVzIFpodToKPj4KPj4gT24gMjAyMS0wNS0xOCAx
MTo1NCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4KPj4+Cj4+PiBBbSAxOC4wNS4y
MSB1bSAxNzo0NSBzY2hyaWViIEphbWVzIFpodToKPj4+Pgo+Pj4+IE9uIDIwMjEtMDUtMTggMTE6
MjMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQW0gMTguMDUuMjEgdW0gMTc6
MTEgc2NocmllYiBKYW1lcyBaaHU6Cj4+Pj4+PiBBZGQgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
IGJlZm9yZSBzZXQgcG93ZXIgZ2F0aW5nIHN0YXRlCj4+Pj4+PiB0byBhdm9pZCByYWNlIGNvbmRp
dGlvbiBpc3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgMTkgKysrKysrKysrKysrKysrKysr
LQo+Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3YxXzAuYyAKPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAu
Ywo+Pj4+Pj4gaW5kZXggMGMxYmVlZi4uNmM1YzA4MyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4+Pj4+IEBAIC0yMzAsMTAgKzIzMCwyNyBAQCBz
dGF0aWMgaW50IHZjbl92MV8wX2h3X2luaXQodm9pZCAqaGFuZGxlKQo+Pj4+Pj4gwqAgc3RhdGlj
IGludCB2Y25fdjFfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKPj4+Pj4+IMKgIHsKPj4+Pj4+IMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKiloYW5kbGU7Cj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsKPj4+
Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+PiArCj4+Pj4+PiArwqDCoMKgIHJpbmcgPSAmYWRldi0+
dmNuLmluc3QtPnJpbmdfZGVjOwo+Pj4+Pj4gK8KgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9IGZh
bHNlOwo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51
bV9lbmNfcmluZ3M7ICsraSkgewo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+
dmNuLmluc3QtPnJpbmdfZW5jW2ldOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpbmctPnNjaGVk
LnJlYWR5ID0gZmFsc2U7Cj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqAg
cmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJpbmdfZGVjOwo+Pj4+Pj4gK8KgwqDCoCByaW5nLT5z
Y2hlZC5yZWFkeSA9IGZhbHNlOwo+Pj4+Pgo+Pj4+PiBUaGlua2luZyBtb3JlIGFib3V0IHRoYXQg
dGhpcyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUgc2NoZWR1bGVyIAo+Pj4+PiB0aHJlYWRzIG11
c3QgdG8gc3RheSByZWFkeSBkdXJpbmcgYSByZXNldC4KPj4+Pj4KPj4+Pj4gVGhpcyBpcyBjb250
cm9sbGVkIGJ5IHRoZSB1cHBlciBsYXllciBhbmQgc2hvdWxkbid0IGJlIG1lc3NlZCB3aXRoIAo+
Pj4+PiBpbiB0aGUgaGFyZHdhcmUgc3BlY2lmaWMgYmFja2VuZCBhdCBhbGwuCj4+Pj4KPj4+Pj4g
W0paXSBJIHBvcnRlZCB0aGlzIGZyb20gY3VycmVudCB2Y24zIGh3X2ZpbmkuIEp1c3Qgd2FudCB0
byBtYWtlIAo+Pj4+PiBzdXJlIHRoYXQgbm8gbW9yZSBuZXcgam9icyB3aWxsIGJlIHNjaGVkdWxl
ZCBhZnRlciBzdXNwZW5kIHByb2Nlc3MgCj4+Pj4+IHN0YXJ0cy4KPj4+PiBJdCBtYXkgYSByZWR1
bmRhbmN5LCBzaW5jZSBzY2hlZHVsZXIgbWF5YmUgYWxyZWFkeSBzdXNwZW5kLiBJIGNhbiAKPj4+
PiByZW1vdmUgdGhvc2UgaWYgeW91IGFyZSBzdXJlIG5vIHNpZGUgZWZmZWN0LAo+Pj4KPj4+IFdl
bGwsIHdlICptdXN0KiByZW1vdmUgdGhvc2UuIFRoaXMgZmxhZyBjb250cm9scyBpZiB0aGUgaGFy
ZHdhcmUgCj4+PiBlbmdpbmUgY2FuIGJlIHVzZWQgZm9yIGNvbW1hbmQgc3VibWlzc2lvbiBhbmQg
aXMgb25seSBiZSBzZXQgdG8gCj4+PiB0cnVlL2ZhbHNlIGR1cmluZyBpbml0aWFsIGRyaXZlciBs
b2FkLgo+Pj4KPj4+IElmIHlvdSBjaGFuZ2UgaXQgdG8gZmFsc2UgZHVyaW5nIGh3X2ZpbmkgdGhl
IGVuZ2luZSB3b24ndCB3b3JrIAo+Pj4gY29ycmVjdGx5IGFueSBtb3JlIGFmdGVyIEdQVSByZXNl
dCBvciByZXN1bWUuCj4+IFtKWl0gSWYgSSByZWNhbGxlZCBjb3JyZWN0bHkgdGF0IGh3X2luaXQg
d2lsbCBiZSBjYWxsZWQgZXZlcnkgdGltZSAKPj4gYWZ0ZXIgR1BVIHJlc2V0IG9yIHN1c3BlbmQv
cmVzdW1lLAo+Cj4gWWVzIHRoYXQncyBjb3JyZWN0Lgo+Cj4gQnV0IGJlZm9yZSB0aGF0IGFuZCBk
dXJpbmcgR1BVIHJlc2V0IHRoZSByZWFkeSBmbGFnIGlzIHRoZW4gZmFsc2UgZm9yIAo+IGEgc2hv
cnQgcGVyaW9kIG9mIHRpbWUgd2hpY2ggd291bGQgcmVzdWx0IGluIHVzZXJzcGFjZSBhcHBsaWNh
dGlvbnMgCj4gY3Jhc2hpbmcgd2hlbiB0aGV5IHRyeSB0byBzdWJtaXQgc29tZXRoaW5nLgpbSlpd
wqAgQXBwbGljYXRpb24gc2hvdWxkIGhhbmRsZSBzaXR1YXRpb24gd2hlbiBzdWJtaXNzaW9uIGZh
aWxlZCB3aXRob3V0IApjcmFzaC5NYXliZSBkcml2ZXIgc2hvdWxkIHJldHVybiAtRUFHQUlOIHRv
IGFzayBhcHBsaWNhdGlvbiB0byBzdWJtaXQgCmpvYiBsYXRlciB3aGVuIGdwdSBpcyB1bmRlciBy
ZXNldC9zdXNwZW5kLXJlc3VtZS4KPgo+IFRoZSBmbGFnIGVzc2VudGlhbGx5IHNheXMgdGhhdCB1
c2Vyc3BhY2UgY2FuIHN1Ym1pdCBqb2JzIHRvIHRoZSAKPiBzY2hlZHVsZXIuIFByb2Nlc3Npbmcg
b2YgdGhvc2Ugam9icyBpcyBvZiBjb3Vyc2Ugb25seSBzdGFydGVkIGFmdGVyIAo+IHRoZSBoYXJk
d2FyZSBpcyByZS1pbml0aWFsaXplZCwgYnV0IHB1c2hpbmcgam9icyBkb3duIHRoZSBwaXBlIGlz
IAo+IHN0aWxsIHBlcmZlY3RseSB2YWxpZCBpbiB0aGF0IHNpdHVhdGlvbi4KW0paXSBJIGFtIHdv
bmRlcmluZyBpZiBpdCBpcyByZXF1ZXN0ZWQgdG8gc3RvcCBzY2hlZHVsaW5nIG5ldyBqb2JzIApi
ZWZvcmUgc2F2ZSBiby4KPgo+IENocmlzdGlhbi4KPgo+Pj4KPj4+IElmIHlvdSBoYXZlIGFueSBp
ZGVhIGhvdyB0byBkb2N1bWVudCB0aGF0IGZhY3QgdGhlbiBwbGVhc2Ugc3BlYWsgdXAsIAo+Pj4g
Y2F1c2Ugd2UgaGFkIHRoaXMgcHJvYmxlbSBhIGNvdXBsZSBvZiB0aW1lcyBub3cuCj4+Pgo+Pj4g
SnVzdCBzZW5kIG91dCBhIHBhdGNoIGZpeGluZyB2YXJpb3VzIG90aGVyIG9jY2FzaW9ucyBvZiB0
aGF0Lgo+Pj4KPj4+IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+Cj4+Pj4+IEkndmUg
cmVtb3ZlZCBhbGwgb2YgdGhvc2UgYSBjb3VwbGUgb2YgeWVhcnMgYWdvLgo+Pj4+Pgo+Pj4+PiBS
ZWdhcmRzLAo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+PiArCj4+Pj4+PiArIGNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+Pj4+PiDCoCDCoMKgwqDC
oMKgIGlmICgoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB8fAo+Pj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1tVVZEX1NUQVRVUykpCj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgKGFkZXYtPnZjbi5jdXJfc3RhdGUgIT0gQU1EX1BHX1NUQVRF
X0dBVEUgJiYKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1t
VVZEX1NUQVRVUykpKSB7Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmNuX3YxXzBfc2V0X3Bv
d2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9QR19TVEFURV9HQVRFKTsKPj4+Pj4+ICvCoMKgwqAg
fQo+Pj4+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4+IMKgIH0KPj4+Pj4KPj4+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
