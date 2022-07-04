Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D68CCCA479
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jul 2022 16:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4416810F21F;
	Mon,  4 Jul 2022 16:15:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC0110E00A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jul 2022 06:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKCZqBXbP5AvWC9Vii11sEL1czsgzg3QNWlt4V2VBljMJRbKQefxBZzxMBseoC4Ws0fHzvxOWRLst1OQuGFhmDy8kpDAg+lmyk6IE7/BrxQzAApWi6E1LtG3NaVoSZNAwt0fAUAyZ76/O7L/v7aLmwnYDnlDOWWqpMjJg97lBWVMylRWY0Us7eGDqhRrlVwI26bn9JRQa2CpYbPFETFQ1q/lmfv0TPs5G0iOITwx5pNVQaYeNsg/zJQZl4OvaT8sPUuLauw3nLlSWXLPaKdaJuSeXVk8EpVjWyhsJ5OLNI6vSifmnn2r+5iqAlRWcpkOeCw+r4+ECAiJ7htpd9iaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzRCWZZAGwph0dfDhaBFX13YTfxVCblCWsNg1gt/CGE=;
 b=HFOUUUdEqOV0ZgkyZc8LkMVSdyDaRXPDAWDDtRYgYI3MaMxKoX/XS8Zh4LDW5UA9aYNghvt+iCMBKdt9ObLMC2IrcLqyYFWzHs4MawtZsbYdZdiSXMhDuYXYrH7YNLfX71TC1qerW5KeN1qRinxSscslZBHYlrmwVuM3fWd2A9BLecPiKDVImlmlMRpzx5kPRFmXdAzzfvZCzke5OP11H97PxOi1DHz2afQkKZsJgp59puKjRISnDuYzwEAY7+4lB5YjL7klTujGIBRzJJ8O/RCaGv+qCvXY+Bk/g28WbeHn2quK4AcxT57xxNF+CyJRbmQYlLy40blbWaQF4pf7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzRCWZZAGwph0dfDhaBFX13YTfxVCblCWsNg1gt/CGE=;
 b=OmoOcQePL13Hci+3+DUrzm6nPDHK/JRctiZ9m9YjCeJzBXpymaEj3ZMNP4CRCE6ucBqqRtrOAC25jf5QImeSYoiDLQ8k4/kKJoaG/dwvv/WxZA57JOEy0ZsCKq7l4vqLH40Ttv/po3OOq/SjHqYiyjI42QUWqbUjS9fe4frTk2o=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 06:11:52 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::7065:5dfb:f610:4fe]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::7065:5dfb:f610:4fe%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:11:52 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: add umc ras functions for navi31
Thread-Topic: [PATCH] drm/amdgpu: add umc ras functions for navi31
Thread-Index: AQHYj2z0Dt8rWeY+vUC65ESBMtkotQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Mon, 4 Jul 2022 06:11:52 +0000
Message-ID: <CH2PR12MB4215B5113E89BF5F2D68C76BFCBE9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6abc2dcd-fb2c-46a5-a047-08da5d8416aa
x-ms-traffictypediagnostic: BY5PR12MB3713:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6D64znzrrw2gQbfXneQHmSq1CjSzD4iQ7rC2iJModZLg7oRtC+UBrveUrae5wpDJWa9OuCQARH3Go0lkU4Mhc7HG3/R4qHy+AjoqBXx963u/OWoCHWhCyu1Fcjr94Y5m2l4cFjIk++KYzLkUsKlAUL++xOPUikQW3GOj7+p4k53AW0UAi2bTdHM/+hxyyEw8dMXR5hI+QQcj50rJAYYxfha4TH8jOJwg/HZ71Iupa3qfmYWUD81OEhFhRURnvydeOiTzxGT7tKRoFsqorgV/qHTtXHGTRb5bLJjzyfyGS1dG6rz4PAP9PvDXn0GYEbkN4Lpjg8LFJzrhePvmQIKwpRoj3WzmsDsrNxIiK/wviF7mY4E93+duYCcUX9fXIEqwxzA+65NllrN/juM2VfiNxLhUJSoGrEUA04iDoWURmPAwLvdU5WbSpyvNVTSKxJnlxqSKzVVemydMNOp24wDHAXQXdcTN03ViYeOuEFXV40MpgUrx/+yacqU1FhMDH60fkSc7wsCUVKhc/fakxEGe2sQTHVeA3l+08quBcgnxA3CnPxkWVEoGKIi/vSdxU2Cp7RBLUAtqoOulUAjmgveZfTTtVBQkWDnbISrmLWVBumAp6fqXr//KSC07qhaSyypATsFDBsYGz3+aDDcIqYdTzPtS1tIJCcjW/cbxwQn1nKndwZmwVbbDvJtiADG5HDOYMmLuMBrfV61tQPHA9TGqUVk72AWPACrVyDOta55Vh1u8/vkt+W6MTySSYoi3RtINMiY+lEtB6fs1zO4Am9ngfK7ccVqofMfkfAfxoRCeo8iweYghjwuOichNLO48UZ8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(186003)(38070700005)(38100700002)(55016003)(64756008)(71200400001)(6916009)(66476007)(66446008)(316002)(66556008)(66946007)(76116006)(8676002)(4326008)(83380400001)(54906003)(7696005)(9686003)(33656002)(5660300002)(6506007)(478600001)(8936002)(52536014)(122000001)(86362001)(558084003)(26005)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?94bC1EMgOvBsuPlJKLDXjomC+Y+AfHo4YAbfjpZRf5n4e2A+U5qORJnQNw96?=
 =?us-ascii?Q?X77szKM9aIiJPPxCVDLL0XZuCyH6RiNcP6ektWMfQpABCLQIXtTzFaohTCzb?=
 =?us-ascii?Q?hDeScTvQfOftK+Z5BpoOPELUmyTYbAFHeW2TJYJ+KtR+EXX7W8szwVuiW8H3?=
 =?us-ascii?Q?cHibrOk74GYslBqWhe6qfUmx95JOChEs2Dd5dkZNfdJYzdFjqZEvJFf3Uu5j?=
 =?us-ascii?Q?pRTdSjT66k+InqQkqSXvpATQrQ7r1p8GE2TkHmtgfBeb0yKFNBxLiC9BNNIy?=
 =?us-ascii?Q?JsiQzA2aka1ELo9k7yJtbiifrBmDBEg5GCkL0N0Mc7MKfhuBBOorkVPS+9H1?=
 =?us-ascii?Q?ERV8tB6SbS4PEHIA2TAdDeCsRa6JJgBjIU14AHKYhULOlkEm5aYLDytDakfN?=
 =?us-ascii?Q?IsQZGpfffZ4dyTAwgLD3PhgFx2ZDsIILE2hdu5gDE4hbjL4SvCDq/iQBIBKP?=
 =?us-ascii?Q?mialypK4+wpM6lXnWUTF42kGMo2z9bEBWD8bWiu0LZXWUAiGnKCdYfcWg2X0?=
 =?us-ascii?Q?YplDRgLWZpb4NDe9sGBNGV8yacBvbPbHVJBDUampxFcLqnY+3MrphOyIQw1T?=
 =?us-ascii?Q?XdK68StA31iVk1h+NdIuE85zaYamkG+XpZEHLUc1xGJtDKN8DOfkJfpVRsuu?=
 =?us-ascii?Q?gr7VgCt7IAJOZOrHmU7xtQpwSyEuDSsPmK1GlfUOpE8XOFOt1RYaQ52XPswo?=
 =?us-ascii?Q?Z9wAqaYWW40sedxpWhbWCKqjGNQg8Qfv8wwsDO9OVuqeC2ZcJFjsCWvvt6nB?=
 =?us-ascii?Q?0EnKh7VvBF7tzoIX8IhV87RFnhhHeeRB7PO86E7IEsj6F5cLqurpqNYOv9hS?=
 =?us-ascii?Q?7CfHEz5RG8ycIHzveSWkLwtin5J9ERT38RW5/Tx0YT+8wOfqyx8ItR6xY0Op?=
 =?us-ascii?Q?zHPV/cRLr1eR+ifGGVSQ/OC2ymq3qm+JfjnKBZ4wW1nJcRWCI3zdHXaPMQlJ?=
 =?us-ascii?Q?p5kU9YyO5ZPoS0d9akinRa+zHoXEns8p4xtXY4PzpF7tDufINx/LQwScmcq4?=
 =?us-ascii?Q?5jw6QDEjyzMGuP7bOQ3yRZWaUwkHCo0QlwFJkWWw49x7Ixb72UI76SmeLpE9?=
 =?us-ascii?Q?kU6rlk4wJ06LRlKqtWM8jUM2W8wnr59ow7MnEPi3nhCkD973JXefBzSl1RCA?=
 =?us-ascii?Q?JmbTBlUlBeRR1TqWaeUhPytMrlYBio7HPIx1mBEKFn9hG937LRsdr/t0twcm?=
 =?us-ascii?Q?DEYHNRuPD420Sf8EBABmra6m1O9qW/8WZmARmaIMlsOXk/3r+ZaGhYSRW4xU?=
 =?us-ascii?Q?xfOKJURZts0K6n2tQumO56kSu7/40h73dtE0vPV/LgP9sWE/zNhhu06b2Odc?=
 =?us-ascii?Q?hD2bAB4i9jZQnG+8xFgD0YmiG+DK+nc6TRYpp7CvHjoOcvbHIoWqJDJZkhvv?=
 =?us-ascii?Q?x8KIBdisRNfwlbrsHZELSbEkijjup4WAOcMlPfoq9y6/p1jVc92s7IgErn0n?=
 =?us-ascii?Q?o1RY6Iz6EiO/mrCqyHIm3Jtg9q/wVhHDumfGkqQfJLp0BmSa1SiGLfDaIO4i?=
 =?us-ascii?Q?o2eqzBEkqISt4r7syK9XoqtHl9zpHEXNGmkMiUntIGkXkKErmQHaPnrmdLC5?=
 =?us-ascii?Q?VU6e7jd2OiOUmcEKNQ47ieCAuxKZowjacSQo88CR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abc2dcd-fb2c-46a5-a047-08da5d8416aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:11:52.3537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff7HI56442u7rqX+NEUQV1jmb2P4Setb07k8xRYVlNe5eo7VrFYKJbnDv7axmnJ7I6lPaOs1GYB/w+ggGUlTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Chai, Thomas would like to recall the message, "[PATCH] drm/amdgpu: add umc=
 ras functions for navi31".=
