Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D1C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FBD239D1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FBD239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940B96E239;
	Thu, 10 Dec 2020 02:44:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2A76E239
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw1ZRKW7aNPhnaqQpJOyTjaeU9msH+5VGhss/OPRGgSXtX+hdiG9eUI7yyvfTt2tLrmecQCg15i6mAot+GrIELYQkoFgpfWGAD4j2Wujj0X6Ud+k3L9i4X+8hUL4hBicCQyRc/3KBtI5McqkCqPPGMAel3RI53MyVEOgmEFtpDbPshDEdqKcegKRmk3CwNUCVMx0onm8Bsl2og3r4aB9HxAesiN5C1OJB7ivCqkGDNqj6VEo7Gf+42GxHPCM25SD0vNnDiTcat+pZzxugwqwPfy6iUhpQ6cNJzJFMKNkV2S0tctDPv9qzkDquByAHJjIwfQwFFoXvJwrZ0Ji4x0gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9ru9rS8qA76+ESswRHU8ne/uW9rv7wfGDry6WhnCP0=;
 b=ec4kIFZLh1U8BjwZq2QOGONALqreYo5Nqd35XHI4uCTw91sCMAKYx4lef7ASBsQJSBQEJDYFt1A4HPN1+uvKm3gI0WYhi+RR4ClcdtakWqFG/lzGf6YtZjVcgMX6MbDtto4YetqkKJBc0QfKTAGnejcrxSPoipIY5cIoVWzIyFd2r8QCPFyP67OzKOPBvKSi7mhdIxSXwzVbbWAQX1twt9sTG3r+gn7/FiX/cHXaTkMBf5Nf8DXz4i072YmKhY824+Cl0T86QeeCQIO82FS96gYMEsSmLXy2OMmyBn2xkuo429SPmCwb3pegIVEEeSmZSNB1S9l8cQgDXAmb3hz2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9ru9rS8qA76+ESswRHU8ne/uW9rv7wfGDry6WhnCP0=;
 b=RrJGGJIm1macZyNSLN/Zknzwk8ZjGixqZmfaaoB0O897v+CuIIpYmd5TzmfU/dXisruXjqnnAxe5eQGqw8IanBFdfhsjcHzLeT5+UPgqHatYBH/V6x3Y9otKr5v9TN6Gcfzqn9y8QoluRfcJj72SMAwsEuebU1RdtnvKx+FeEOY=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 02:44:26 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 02:44:26 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0
 port workaround
Thread-Topic: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Thread-Index: AQHWzp5fpJWH7+PSgEyKhtRBE8Ze7A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 10 Dec 2020 02:44:26 +0000
Message-ID: <BY5PR12MB4885F47C87165B8427F7EE17EACB0@BY5PR12MB4885.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b92ad289-ae5c-4655-bf30-08d89cb5827f
x-ms-traffictypediagnostic: BYAPR12MB3462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3462EE3B6B3A1666CE5FCEC4EACB0@BYAPR12MB3462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ct1NLgU8Am7n2ZlunzYJnWumjduncL8mv4BVmeTU4t9jG+7Cz/jnuHkrbCFnhCZdMIsikiL4Nyli+dxjMTRzI4CSeUYMqSAv0iZH0iMRMJpP72zGGLV5TjUKqds5SiWDc/C6SuyBkb2utWPJS/SR2b3108I2/aMlTiOsGu92abpR71AjkciBr+FSo7pMkdF3OlkaJjGjB4vz14Xz0cr83Qp6YE4McrHobfsLHYpYg1aZMFvyd46iUuupZeiyOPcgjg+r5WTl6V0ot529Gzd0WrAbwiL9eBuUufqqRbxMbeyOh79bVm779J7Eh7kolrkj8ptQFicYcYAqPoYEUwgaTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(5660300002)(8936002)(54906003)(64756008)(83380400001)(66476007)(86362001)(66946007)(66446008)(76116006)(66556008)(508600001)(26005)(7696005)(110136005)(186003)(33656002)(558084003)(71200400001)(52536014)(2906002)(6506007)(4326008)(8676002)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kLuu4vlaQaIVaBeKY/zHPhvY3ZMhZBHYO2CaHFOfhwCgvR7uPDdMEfPkVjEy?=
 =?us-ascii?Q?xXzlOI/Kp/7NLWWaLd0my1SVJ4lVUCph1rbhlDVq2NC9QHy4RIqnbWflPz+3?=
 =?us-ascii?Q?lbw49dq5rZG3I7vq196PhqY4TqAsq871tDxtxmr7BBKhb6sAo+FT+UpKc87N?=
 =?us-ascii?Q?Am2PKddNLflBctx7bSKNMx3p9OhNKmjWxhuFPlUemuDUjOLR7Tb701h/xXCR?=
 =?us-ascii?Q?qA5+fcN2qgX6isCsD7CMYV8oyjFwrL+Osiks+cL02JPK8BOv6F5JhkzxbUv5?=
 =?us-ascii?Q?DvFRqT1SDKKirihlW95Yf0/L2cnvFmoaABnUYOwnzeeixJ3Uv5wl2t40j/Yn?=
 =?us-ascii?Q?waVcjCaQqeESgPzIsAguT2kAIuV3Ci2R7BmP2VoZMiUaW4sc8dmdZ/m0SSAc?=
 =?us-ascii?Q?VBO2OQDdGluRoebx16xwLw43INm5smSQbIgWukSaU8PfaJH8WF0971FcnsJ4?=
 =?us-ascii?Q?GWhF/6lt8s9/D/oH9H92VqRkwzqhTByxBASet/fypyx10LERoIMfj8YnuxHW?=
 =?us-ascii?Q?c3eDAim3B3znb2Xj8sxJZ7I3ThCzBWTL/5JuFosBLWrhkUPNt/ntJDLWZQEk?=
 =?us-ascii?Q?RLLHi5lUN86BzFehLuwIeSU6P7SwclZ2rHTSUs+gDAlKf+Aw5NIUi5dqWMEh?=
 =?us-ascii?Q?14MQkhMB6WfMTDHQp4vXx4FKRvttqLg3rN7prf3FZJUk6JGhjSNzDUkkpPuc?=
 =?us-ascii?Q?su3+i4zyIejCgIZ0ckM3k1EbHRJjCmfBj/ts71trxdRrGWQFFD+I1lOxMHAB?=
 =?us-ascii?Q?wJ4/C/CSJkD+WXPDGmC6RBP5wliCJcGAG+LvO+QZhqN6Op+mVviA3NpYPuvb?=
 =?us-ascii?Q?TdoZAMqiDMH5qhosNN2n/mwYO+Ceq9xmOqa4MeFs8XY/M2YYCbYKddG7lRuB?=
 =?us-ascii?Q?la+OPJEZFSR4RwseG9pMtB9JU4gEv3KFlVBA3TbQSAiwv6ygXP1fNtzRHT9A?=
 =?us-ascii?Q?aJ2c85oh0kwlmNhkGAGzwv8pjfxuPf1gMhRT7/QRBrQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92ad289-ae5c-4655-bf30-08d89cb5827f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 02:44:26.4592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIieiAPGNxfeqdXZF6+PLh3DxMgalQzWIm43ftbE7XA9C9ghNl7J+ifN8uDyuauqoqaq+9JGxJnZ5h030kLQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Chen, Jiansong (Simon) would like to recall the message, "[PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port workaround".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
