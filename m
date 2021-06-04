Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8336C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B14611CA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B14611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA1E6E9DD;
	Fri,  4 Jun 2021 14:21:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77426E9DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 14:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTNEhkpvWPHk8tGgeNgVIDHMuPc2P+d418Xq6583r0pgIJp9UaXVMydLLhb20V0YDzBw1hFlZJqWoVjGNGtLHlGD5GF9qXlhyzSDdsGYQo+t7D4Dsi5TNqzUnXdkrTbewoQbaFxA5UwxSk9AykLrfJ6yTqzEyKFOzBxDzJ0fKujCRwbOZTl9BKSCP0jX1zSRJcQIxiC9y168OQdCPG2RKKZH+wibwwpqbhwl+SkmvELs+ahXfP5L7jQA7Z/KKXDt8YclUFSWCKK4juvNOrchmFXxp8gudJm+fXtu+ZHoJ8VQIEXG8/jJxXZ8JTBVIg1fIJnFw2VoRmiOGR7JczPJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3AnFfRLcCRnmdiTHRum6GVzMSxuOyiU7fc3D+YbMEM=;
 b=N6W2oOB2FBfX55f9GD7z7hmshEQtRokzD2BrVt52n4RgxIkV8ZTVvv8uxARhnl34UZkofSiTd40Q5hxLv14xnC76AshZFLCJJmQYA40dKxuwf28xISV3DM8EzXm5LUZOIb7f2YcBvtbuUwaOUNxAVhcQBY+LlKkplsGXMpm418shMzveWi6X3RcuoVmrBauGOsd49r4hJhjvTtzRjsmWGXKw7NcC8yBY87budE/Uqo21xzB++hkfn8rbIuTgzl5Bt4Ng7YmlBHY8IoGeePlfbtzfnVLb6ofkO2Zr32ML2QtKe9sNMm5MDqqQbWJmnkKzw2QIYHClN3tn0xilpLEVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3AnFfRLcCRnmdiTHRum6GVzMSxuOyiU7fc3D+YbMEM=;
 b=lay2AVoxMtoWADM98ZoiVOJSZgdKIRncDTQldUad3hZf/TGsStd0ww63cFuSUc0uVEV+s3yDPQjVcnkEDuLBTfzNoJJLlZ1/VA7zQ75113E53iU+l2+xN/E+gL0Z7cmM2nKA6ZMrp4+xhAGRR4zn0oje0iTiq4t+vIrWVpuk5vQ=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM5PR12MB1897.namprd12.prod.outlook.com (2603:10b6:3:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:21:52 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:21:51 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHnOs5rKx+Wikmn/4L8wjao+asAI9aAgAIf2ACAAA/aAIAAzceAgAArOACAAJq/oA==
Date: Fri, 4 Jun 2021 14:21:48 +0000
Message-ID: <DM6PR12MB306752C4E3B02839207522F58A3B9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
 <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CH0PR12MB53480D82E2D1C8EF998760F4973C9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <DM6PR12MB26197ADDF59681FD0902780DE43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB5348CA39DC370EEDE3817C99973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348CA39DC370EEDE3817C99973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T04:51:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:1020:cb:e5f3:91cd:3ccb:2776]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a32fff1-20b0-4090-b990-08d927641900
x-ms-traffictypediagnostic: DM5PR12MB1897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1897F88D147F3A1517DEA1DF8A3B9@DM5PR12MB1897.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cqoaU650xFBTIO87PNNIUSs+Uy69urPM96O5v/poSCuQ0C3iP21SZrJR2WOYY5DykPR+FMN09FX9oNXwNa4nM28K00BvCbsmXxZKNwTCD5AXPCPoe7yuFJo5BlqtCLUN9aRS9upJ9wIimuJG6+iHKvrgv09FGIJbWHN8mdbKVRxfYmUMyTtteKvh5kvmSk21p5AZkZa/qusUupi+MEtlc8GhVC+2lv6R5Fv+Wb9O4tNgU129hzfGsvhcnzBEFUqMjxZJRGyrC4iYLVOnq9rJCSdzjr1BPSxgS50aAcFIBi8JqgQ21RxD7AwbLUCGlwNTv2pPdP5IkFTNMdX/UaKtaf8Eb1qoFDFazF9T0t3Brx2k24e4qexw+SYFm+mZPYZSekXg9fJxzKuokfQXY3vw1qHleNaYgZ8RDFdY5Gai5ekwBug6R0uLp/0eyi8ZaG4gecG9aoJ7fJeMJLqbMF6XeuHnNXOcX19ioMo8eS6jomPJ4PRmOyVamBhm7vsySsqHIBEjE040kPXmVi51dgbJjx6wzTOIOzTM6tIx2ANflQ3eRJcmw4vbirXG57WtQffJ4BgOJ7RdJ1KQIWW80uTxdfLjgvyqFUQP9Ew3k2gFpPMkB9iZ8uMWW27OEe7edjAbvhS9rzo7WiDBKn5zaiuMmuSQ4q9bqzHF6YOpT/VJXSAvwowcwCWUIbWmHitA0zZ8uJKdVLM5R4sSy/B64OZGBL7KciQEYLyU5JdbmAv9/CGhNU/useNDd5XWRcj4hh7c6CJlRxEQxHLuamOMpejrOd7A3qAfrLFJv4FBVVjrxdI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(122000001)(8676002)(478600001)(6506007)(6666004)(53546011)(83380400001)(8936002)(66946007)(316002)(66476007)(76116006)(52536014)(966005)(86362001)(66556008)(66446008)(186003)(64756008)(38100700002)(54906003)(2906002)(9686003)(5660300002)(110136005)(33656002)(55016002)(4326008)(71200400001)(45080400002)(7696005)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Rpm2s+ks1uDcLjivfJP87l4Gtjh9B/vhWzu48mjd4yPXnZjj1cWh0FNQIvPM?=
 =?us-ascii?Q?Ik9m672Yzv6Dh4vIt+DkICm4Iz8CSixkHJRJm8R+iGF0kxRQmTibfVS/ePbb?=
 =?us-ascii?Q?UwrXkeJAc49B8yxlcTL00zmrIgVJWKS4aa9uKzGiRO4ghIeCYlkd69ks4g9u?=
 =?us-ascii?Q?SCmaVf0akSBrYw6sgFWXxG7gc3fUE9e35K5h+HDbasN8/UmYxzszQ2rRjgwj?=
 =?us-ascii?Q?Df1Be11+tCgQW2UwZNvF7kypl3X+tO6XHRfItJ/elcZLVxdIH56WWWvhUaed?=
 =?us-ascii?Q?spKK/Ze84CaGOpLQ0LT22oSwNb8rcsf5JdIAKFwlY0i2EVOnjtTy1fjvsTK2?=
 =?us-ascii?Q?CDtTpCiKaMdy3eA9ywHGhkb2C3tA4MzRxXYQ/v4KUOpSBT7apozE1T31JncN?=
 =?us-ascii?Q?xTu2DqBH3uJFu4xX7OXHJyU7YdP4HuuAXmRgKQmVhEnvieLKBwdkoQg5uyv7?=
 =?us-ascii?Q?cLfmwo/Sm1KCkzOUCP5KVpt/5xQjM+mDJSNZlYi+41oJhpkXd3bjvplGDCZY?=
 =?us-ascii?Q?o23K2XE1bvw5dwQ30l/xLdn2Do0nr/nic3MVd9fABMD4hYXoOcGYZLGMdKaZ?=
 =?us-ascii?Q?CrQrjMzwbvM9EAdqKAyfCz9OFNN6AKFUKcucCwAP6ZZM1kuGMipVQjYuQ9HT?=
 =?us-ascii?Q?QNp9ui1tWzcwdLWf5t+26MULApbz9R0X0W8h64gM3OFN9KkO2vaJJJQ++naf?=
 =?us-ascii?Q?KkM/agTw3MEd5RhLYOS72FeZxN5slRqFebhspPkZcui3yBnBRHoP9RiXIZiY?=
 =?us-ascii?Q?8Ix0xCymm2rH8FkEXoGI4wxvA19Q346j1W2J6X3UAZCMH8RotPtO9rfndNxB?=
 =?us-ascii?Q?GOagpI/l70Cz47PHdQXcSn9WlFHYfwiwnuatixt0p1MflFRwtrOhZ+BSeQhX?=
 =?us-ascii?Q?pIqvsFQBeSsHliU18lsdt0TXaWp1YctIANbewXomtPCKKrXFzjr4PeA4/XpJ?=
 =?us-ascii?Q?jcdHKA4p7iXJDjq3g8+HqdfXVZZoW4dB4UScfhIoya2AQo8ydAOzmnPkC4vZ?=
 =?us-ascii?Q?x71wcWqoTodkn1oText4wkQTFBIpyQh9tKZ3dl855awhOoFb7bZfdUwslVEw?=
 =?us-ascii?Q?kUtYhp7QXLTdpjKhovoIzJt3+7P583LsQ1pUQ+jcf3ujsjqKOUcyBDQXpt4J?=
 =?us-ascii?Q?YJUUbbGW721ogjm1GO/oHsf0o/pENK1jCsBjJjT7biUmhQHRkh+vbygFeS1J?=
 =?us-ascii?Q?CNN86w4v7PH7ntZCxZZKQN3hXWvRXjI/Admvbf9AcuYdXp8kNdwL3kK3bFT1?=
 =?us-ascii?Q?BBxwqtL8VQ54q1TQouvLY2w/iA6JeeDEBDQmY8oa3w9DD9JVIYgLTit/LlLa?=
 =?us-ascii?Q?SRfu+h7AaKo7Wt00Ku1OxnXM/mD5WZsjsY6rTsVxNozlijf10/M8COpL2Bo6?=
 =?us-ascii?Q?RlbcPHkrcy70WPx92cO4uznXKch4?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a32fff1-20b0-4090-b990-08d927641900
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:21:50.9562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fluTQbwK2wwn9wpPGRD28fsr3tB7ro4Kn8Q0Ik0Af3iqo0P3AW6wwiXAKfCCkxqVvmRXREJboQVTk8kj6Zl7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1897
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Evan and Lijo. Keep in mind that the ASIC dependent DWORD with those bits is still being kept. That said, I have no problem with listing them out separately in the new field as well. I'll make the ASICs that don't support VR_MEM1/LIQUID1 map to VR_MEM0/LIQUID0 and not touch the *1 bits. If you have a problem with this approach let me know.

Best,
Graham

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Friday, June 4, 2021 12:52 AM
To: Quan, Evan <Evan.Quan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]

A modified version of 2  -  
	List all the possible ones and merge those which mean the same - ex: terminology changes like THM and TEMP.

In the mail earlier, I meant to list them out separately as the intention is to convey the throttle reason to the user- it's better to point out the exact regulator which is heating up. 

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, June 4, 2021 7:47 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]

Thanks Lijo and Graham. Yes, I know that only some specific ASICs support VR_MEM1 and LIQUID1.
However, the problem is about the design:
1. should we just list those which are commonly supported by all ASICs.
2. Or we list all the possible throttlers and mask out those unsupported for some specific ASICs

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, June 3, 2021 10:01 PM
> To: Sider, Graham <Graham.Sider@amd.com>; Quan, Evan 
> <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; 
> Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> [AMD Official Use Only]
> 
> VR_*0/1 reflect the throttle status of separate voltage rails - 
> availability of both depends on board and FW capability to query their temperature.
> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: Thursday, June 3, 2021 6:41 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> Some ASICs use a single VR_MEM bit, whereas others split it into
> VR_MEM0 and VR_MEM1. To avoid confusion, we've combined the VR_MEM0 
> and
> VR_MEM1 bits on those ASICs. For consistency we did the same with
> LIQUID0 and LIQUID1.
> 
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, June 2, 2021 12:37 AM
> To: Sider, Graham <Graham.Sider@amd.com>; amd- 
> gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> > Graham Sider
> > Sent: Wednesday, June 2, 2021 2:12 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> > <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> > <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> > <Elena.Sakhnovitch@amd.com>
> > Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> >
> > Perform dependent to independent throttle status translation for 
> > navi1x. Makes use of lookup table navi1x_throttler_map.
> >
> > Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> > +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 78fe13183e8b..bf376b1be08d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -238,6 +238,28 @@ static struct cmn2asic_mapping 
> > navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
> >  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> >  };
> >
> > +static const uint8_t navi1x_throttler_map[] = {
> > +	[THROTTLER_TEMP_EDGE_BIT]	=
> > (SMU_THROTTLER_TEMP_EDGE_BIT),
> > +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> > (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> > +	[THROTTLER_TEMP_MEM_BIT]	=
> > (SMU_THROTTLER_TEMP_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> > +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> [Quan, Evan] I'm wondering why you map the two ASIC dependent bits to 
> the same non ASIC independent bit. Instead of defining two non ASIC 
> independent bits.
> > +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> > +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> > +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> [Quan, Evan] Same question here and for Patch4.
> 
> BR
> Evan
> > +	[THROTTLER_TDC_GFX_BIT]		=
> > (SMU_THROTTLER_TDC_GFX_BIT),
> > +	[THROTTLER_TDC_SOC_BIT]		=
> > (SMU_THROTTLER_TDC_SOC_BIT),
> > +	[THROTTLER_PPT0_BIT]		=
> > (SMU_THROTTLER_PPT0_BIT),
> > +	[THROTTLER_PPT1_BIT]		=
> > (SMU_THROTTLER_PPT1_BIT),
> > +	[THROTTLER_PPT2_BIT]		=
> > (SMU_THROTTLER_PPT2_BIT),
> > +	[THROTTLER_PPT3_BIT]		=
> > (SMU_THROTTLER_PPT3_BIT),
> > +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> > +	[THROTTLER_PPM_BIT]		=
> > (SMU_THROTTLER_PPM_BIT),
> > +	[THROTTLER_APCC_BIT]		=
> > (SMU_THROTTLER_APCC_BIT),
> > +};
> > +
> > +
> >  static bool is_asic_secure(struct smu_context *smu)  {
> >  	struct amdgpu_device *adev = smu->adev; @@ -524,6 +546,19 @@
> static
> > int navi10_tables_init(struct smu_context
> > *smu)
> >  	return -ENOMEM;
> >  }
> >
> > +static uint64_t navi1x_get_indep_throttler_status(
> > +					const unsigned long dep_status) {
> > +	uint64_t indep_status = 0;
> > +	uint8_t dep_bit = 0;
> > +
> > +	for_each_set_bit(dep_bit, &dep_status, 32)
> > +		indep_status |= smu_u64_throttler_bit(dep_status,
> > +			navi1x_throttler_map[dep_bit], dep_bit);
> > +
> > +	return indep_status;
> > +}
> > +
> >  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
> >  					      MetricsMember_t member,
> >  					      uint32_t *value)
> > @@ -2673,6 +2708,8 @@ static ssize_t 
> > navi10_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct 
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2826,6 +2865,8 @@ static ssize_t 
> > navi12_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct 
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> > freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> >
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> >
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> >
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
