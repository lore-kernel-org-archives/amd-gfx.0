Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F93EC4743D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF09611C1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF09611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A306E0F3;
	Mon,  7 Jun 2021 03:40:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99926E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 03:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO8gpE14FW9BlRlLuAmvM+ReeDEuKCEMAYyu1igrTY4e2b8jJOpZ7Wm8nYTqQD3KyheHe35Kj0KHBmnsfLqE/2HyDIEZDqB0v7iA16+HT/IXtBSmjOybfk10lSzv1oBFdXAmOdBr5Lr/E8/fKFBmO9AnSNjVOt9TYy7MqjUwDbA13eZjcgiSZtT18Y4Q/xBv+ItKRQUjU20zvlPWqXWu261fSnCzasbE7ooNjWIxurXMBvq8Ptl3zwdCkmRZTPdutsSuEDIU8RqtzzBfNtgauKGH0X1tvfm+yW3ySUBBPBUjmkW8rF8DCh9BYi6Hkmi0SQyEHNqRF2zyZj4KfLHPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=cU8DS2qXoKEoBL0rl11lFj++IAbYEGf6VbDFDFatJJNp+qx+0X53CA8kb80UPdDRFtRAPkvBlmCAVRB7554sqGPuwv27PUw3T0K7+ly3Jx2LtXHU97dnOnrGJ428e1cLAkeDBhkb1qW8P4evyazWL0WESzXgkko0WJ9WHhLOIt06hICgKydrBY28qFV7LnhZHEYzAeJOHMLy3AxPVhuTM6GHae0QoB6o3EYX1vZCvqn3jdzjCxrhdAyGfFR2vzRcxw9URaBD0LLHrSC7rr3mzSk3h72TBVM8zUbpc2tbnSGdwluZSHpxXTck/6wWwfPZrdqOBRtUHsZQAQQd03Bqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS1VnUfywRPoE4EuuAQtgS1zMnSNPxvOJSGUdlXfNso=;
 b=mqC7A4l5xAj4CZj6/HpWwL+Ne3gYab7jFNZQaLq+uwwNs/K2Xz25fLfh9FsnjNJ7/KcbhrYG1kCz6alAbV6U/t9uN4+cJErgJPEAcezsPeHhKNiHJWAT3t3WhUp/2Gc2+cfZ09QJCTVQUO+EYpz+NClDeAVcEA0E/qWyHOhJ5dQ=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 03:40:26 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 03:40:26 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AQHXW07abwLh1QSf2EOplIvmMRnDnQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 7 Jun 2021 03:40:26 +0000
Message-ID: <MW2PR12MB468461EA6080403ADACBE2A0FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cd60baf-5cdc-4ef4-8aed-08d92965fd4c
x-ms-traffictypediagnostic: MW2PR12MB2539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB253943B62DFBE2628F9C9AC8FD389@MW2PR12MB2539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHmyUuQQwvx/khW1Ao4126tZer/ASjDBF7tPNzZRSrDfA8ewJzRJziVSwqulxuOMYTF87Vb0zEQgNvuUEz5RGzAruArdasoXAwNKunPjyxoEUyD54BWdLXwAnP/nAHXQ4nLwuZQfKgS9uFYpeLexHsARgsgmix77edp0ye8K51R8pjhivVV8DmO/wE2rJekchoagctJHyUNk+7lQvd/Rl8C4RJVUeOnGXuKWsGKaT4aSay8KsAnOa4o7lCCs0Pitsa6hlmcoivrOZRbc2V9joZO2ns/aRgJuA5mTkBOVJO2ttG3CqWwVlC9ApMEecUYwMwPkk1qCh/4AemyNU3EYItT7iNxt4gnf2CjVmmBmIIhaefsaUSfasfNZjaBV3APP9FSAMRNTPS5JYyhc1BvF310gqmSLxGlJgChSX46nNHudQq2Qcf/n90QMRQq2adfL7Q6GldWmXERbMf95eBbFDInddXpMdcXlRie2X2kpoA4zx4beFMH5+U7Xq48h7ANfM7Bpj/Z2qfgMmz34SpOrI4gs8hjjhIK0gsaFimlBE8n+xZxRGupEv3GcsDFWltsVKY5APbVKFBnN12pvCSo7bP0O5XLGdP0ouHsUYABf5+s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(66476007)(122000001)(66556008)(64756008)(6506007)(66946007)(110136005)(76116006)(83380400001)(5660300002)(316002)(2906002)(38100700002)(478600001)(186003)(52536014)(26005)(7696005)(66446008)(55016002)(9686003)(8676002)(8936002)(558084003)(86362001)(15650500001)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JjxckTZfxtNalxIpkpj0kLaHQY7UnFonneGwfU1bOqeGO3ivTHmXcACh+V99?=
 =?us-ascii?Q?kMPUZNqIA9aANcLoF9b4glnabsOnwIM6VRxcgfTdO9GkFVSDjpzJ/uje1+IC?=
 =?us-ascii?Q?qUBY9A52GSWKpA0wkgYWM5ht1JCYr6kcdT1qhrMxzBnhCTT9PP7p276pyBn4?=
 =?us-ascii?Q?Rbs+hWS4HBp11mUNkBdoDtzQfxckW+EmXSHUVR54tts4rzXEh8OuyNPqJoKw?=
 =?us-ascii?Q?B07ZESSUmfxTrhburQSnW6/kZ1seWB5gbiJ46ZdmTd6IwKJv0BSgtrdwstMv?=
 =?us-ascii?Q?Sg0K7JWpyDJjBlsLLYcxaEHVgUUkKvbJUmBdSns+xtYakwtmfmKrl3I1T+fb?=
 =?us-ascii?Q?nyoqNaltc8Xg6ud6EnFVB4AC48S32h0feSnnA1LXjupRimLs0IxDfhFsqhfi?=
 =?us-ascii?Q?7FrNFlxg8vcfXyE2b0cbFn/E2WrYoxko8JC+oHFakkRrWDF3qVBjM5fzCAbn?=
 =?us-ascii?Q?/CFtx9tZ0kZiAxDiKTN1WvVewdfN7UHOys1MPoIzep4SEaMb473McyXaLOS1?=
 =?us-ascii?Q?p0z0ysGUz5SH32u43lBaKsfb45kxm68zmLeryyFn5FpmE06IoHdXgGmPZipJ?=
 =?us-ascii?Q?/IfEAaZituUyRS6WpSmvi9oylImZpHnUs1tUfcBJMXn4lgG6e2kESNQFwqJW?=
 =?us-ascii?Q?G+xgYS4liuZnIXoykzzERSUfAtBZjOBBPw7XcnU34tJtgrYRlTOxPT8MaZfL?=
 =?us-ascii?Q?y9Tag64/ejB3r5rMfiotEAfyT/v1/fiw/GziU7JI55/8bBkZe9Yr3mLHxnv+?=
 =?us-ascii?Q?cLjLynw6SY5igAbDE9oselfKTRF+PSsvWDRY+L8YHX0on/PGHF2TQkq58A4S?=
 =?us-ascii?Q?TLMYGxcMZ+JwJ6JK/Hmh87XLvMlpg4tm8rijz0MRZfupLD84TC0mpmiYowQt?=
 =?us-ascii?Q?PZvr+tYdFQb4VMjGkIkBFhPZMc6Fc5yq7BeCMYDiF4zXRh5XYAc2es+WfhFC?=
 =?us-ascii?Q?4k1X5GXgCVlmGEmzoK7DVOatUisy6lUQiIKurcE9Y2y8yQMTdBzcWJyjtNLn?=
 =?us-ascii?Q?9SkZ6fFEd4W028jiiSAlAh8APKKdLwWh2OhP7zAupnYZpXuEgrgq+CxAQoyo?=
 =?us-ascii?Q?EwM8BntCm/dbDZecOpc+Xd7ANzltrb04mod0uP0jqWTWAmnRMF1ADS2gVHZY?=
 =?us-ascii?Q?sBKRfmf5NjmB2edxWhiXS1U9O3dHFP15DpH7s4TRFzsMuxNBQPeb3HlweB83?=
 =?us-ascii?Q?IS94FkSpOt9zybpFEzkCtiqYp+6zrCkzJ0IAWsCO/1AZfSX00+XiUkzdk5AM?=
 =?us-ascii?Q?JnrnL34SOyDbzvUBs9xP/kuyFcHnE3os2JjnLgQnT/FJ1RCSf+THYb7+leVd?=
 =?us-ascii?Q?xcVrcozOK2Y+I/7qTGRUatsg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd60baf-5cdc-4ef4-8aed-08d92965fd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:40:26.6064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5IupKkC/BNpnwRWh9BncyM9i5Kgsd0Ls4Ps0xoD3Zm/O81BJb2SIO8U/W0h8bzYUMHGo6KYW3GBLlx0/OnC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhu, Changfeng would like to recall the message, "[PATCH] drm/amdgpu: Update psp fw attestation support list".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
