Return-Path: <SRS0=zsti=PS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5421EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 15:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0406A60F56
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 15:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0406A60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C666E02B;
	Sat, 30 Oct 2021 15:05:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752076E02B
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Oct 2021 15:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ/oAFEy37rugVSu0PyRVjyGOCnlu0nJ4NtslqaYb6tcvnYzNECQhep58ABvgLGkDv3rAQunfT7hD/4v9n4WHIRuvkt4rvl0X9IWzYNMrtsL5TkZ7ly6LbEAQKZWZgGSAv62sBkGOuPKyV+aVvsdmaRR3CB+qyVjml0jsONTkxa7RWJPHZiA+WUQ70txr4204vLpBIzIQpadIcmpFYpzpJKlLEM7AN2w8Qkn4IJm6TrT4Pil9ar0Dt5oPUdk3gMPPp5nk3RG0tZ0/0g5E+cxj6ZYPl5ezVlEsO7z0QhN4O1FotaMNphmajUgecF8w2m1jEOdgxaDLT7FTUxFzzUJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TAMjIzNu/NPitfQDc/IWgt5e87bh7aTB5xH362QbQM=;
 b=h4v7fTjeCIOgPHrqoXrFokypaSyPXO36lCoOexGJajQwcRujgWPScG+uB6bOYyXlm1atCWJ1qcUI1t+mrkVUWszJHw3WBHncmnxHANzvGS3ozf0rxa9BrRVkMLnXFowQvqWo2M3AnmGXlrXlb3hHDVgk50S2OzyLWO2iCG3V43pGSiK1iLv1oxJ/PUdQnB+TDoMksycSj6SQ3tp1xTIhT7u+1Pvp4HqEoaRW6q/QAWGcVXeO1eaxoq+x8ZYdzNo3Y6uzsJazX+eI6un2XPADxCt/ek9yI1swMYXwbtHAQd36X3yg9Tk25eu+tWQjNWOp8viQTNDfnOEEqgmLSuo3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TAMjIzNu/NPitfQDc/IWgt5e87bh7aTB5xH362QbQM=;
 b=OLOJjgvxK80rVEM2331JxoMECivBLYxYlXF7iSE4/eIZBEaXIi5Ylx6YTuXONA7h8i/EKiELCiaQAdPUGSCmDvXRDjbMsRQA0l1CCuFUIz+2U16nFUfDm55PmqO6pJlUicevXDZ73IeKcGKQAYWrMOVbx5fTViV5KX+F3w4Ecmw=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Sat, 30 Oct
 2021 15:05:46 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.017; Sat, 30 Oct 2021
 15:05:46 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Index: AQHXzQpiIf9c19Z+W0GxY0VJfXQSjKvq55aygAC2rgCAAAaGeA==
Date: Sat, 30 Oct 2021 15:05:46 +0000
Message-ID: <DM6PR12MB3930BB63A500C4E548B697FD97889@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211029211717.28519-1-mario.limonciello@amd.com>
 <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
In-Reply-To: <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-30T15:04:38.7904935Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38912402-56e5-4701-dc94-08d99bb6c04e
x-ms-traffictypediagnostic: DM6PR12MB4513:
x-microsoft-antispam-prvs: <DM6PR12MB451307F70DD155F1474795E997889@DM6PR12MB4513.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAoWU9wn3mgr4mc1gojh5FDXgB7iTRYh5E4b391jewok0BH6GS+lEo4kfXeIB/1WEy4iIh3j/TtPcRdDIdTnc6qqMd8zjtH5a4Jop4MC9NYqwNEfsZm7K2Gt9leW7d+bIZltnsmCngTuuINtuDgOrktmAZLmVR3YgtGIlqYzzbWju+oHrnFRFyLiz9/eb5hia3p7p7pIOIEf8GRQdOsRNDcrsNDEqYXa8UH1wmO+4XyywFR3kB/kgln9+/u5hDDiwBhKUUeNzV91mLQ6WPRH6FwJundYmdaSE2HxKenwfwreSM6Rh31KSTO344eqVpk62ngu2g5qguPDtL0/OAmzul6M43/NOIdzp1LkGiaTQ3PEqXE6BRTG56CaSsdZITymudnJmBw0P7NKr2qs0XAJZizMwFjiu5MavFlbwjblQQjUbdbKIAOBYjHI96JOcQH7ME5gxfWj0WkR/HTjL+8SGJGVvyAr7k2ln7Meo5bmFtajQDuT3SQeJouiGyf4wK/WfbamhvVXGFl/6tVRSzGUbHX+hmTysyg+9NFWLdFPK253vzGedwHnGZ/q/4bda+SSaId3pr/QBd0DlM4g7tc+vfysnQGxh6AsAm47xv6p89m0kr4qe6TgKI+9oEQnqwkqH/gZtStszs18dFiNlKxtuRuzSmCNjOEMf9xj9KND2v2pEwSMV+7TsqZhbHjqELLTPsDoyg9lihGbNPHXckQpmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(71200400001)(66946007)(2906002)(7696005)(316002)(6916009)(86362001)(558084003)(4326008)(9686003)(55016002)(8936002)(91956017)(6506007)(54906003)(76116006)(26005)(66556008)(508600001)(5660300002)(38100700002)(64756008)(33656002)(52536014)(122000001)(66446008)(186003)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LtXM7Nibb/XCuxgFKmZ1utd7xY/P7Eb2mhoBFuWiH/94dXczE9+kSO0gQgtp?=
 =?us-ascii?Q?ekiDL05SETWqcHu8YhXRffrYeFv0HM1bFFhPdw5to9YRNjpjL0ZeH2jWYOgR?=
 =?us-ascii?Q?efmf+nU4aOabPmFQz/i2eyy8ONSHkSmlxPEC1TLE3OHkiGU6utG8ChgwuzBe?=
 =?us-ascii?Q?cPWDtXsnFf6pQzKGJNKlJRJUvYlUoO/Gg3/y/unJIwIAzHQJjWycG0XMrAGA?=
 =?us-ascii?Q?BpKE8Fu0zAUi1s3UYwY4YileyjJcKPfLCS0rf+kkoWli96olpMGMDHmC+Vv2?=
 =?us-ascii?Q?2TzL6QZhriWV8mUwL29sVsX7FWoK3bYoZvcV/qCYlFV6nFf6anS6kemaPTZd?=
 =?us-ascii?Q?RVq2vkbJ4EeCHBqluwa5ZTpRliJM8a5sRVCpbohhASzcsY7dNrB/O/MbujMP?=
 =?us-ascii?Q?muuLBp0ob1S3V3evfb43oVkMZybxJorLl+0BknBqBY6ACyXIf2hKYU/Xd1+S?=
 =?us-ascii?Q?RDpGfpTk/I/gNR6kXJe+qztORdSHRYhUl8+/sBfliT4rR50xctlFFGBhOHSk?=
 =?us-ascii?Q?mQEIo6wBSLZhSNEKe5aTokZ7yHHB8mO+AEoqC/Fo8vSrpeUFV8Fh/mXy9koD?=
 =?us-ascii?Q?V+aWOy2tXqXTGNQ3UF42QgNnVnmPybGASl75UNaxcUY4DYp3hBazjD2+qGob?=
 =?us-ascii?Q?lJpiZ3rZy1aFvSGEaascLYBxpAUR67rgW+zM693GpoT2UASy2iqES3IgrKLl?=
 =?us-ascii?Q?oG2wHHWtIOG05C4Qj5x6Su4P8XzHzwBmmU5feCcc98WRBB1R+GpCZyDkYVnw?=
 =?us-ascii?Q?vowdtObA63ofHUxthTq4FE7E+8VDmDYUA6mtrF+/y7ceeffS2kVYJAbzoIp/?=
 =?us-ascii?Q?gI/L4O9Y56r0u78R0WCjIPh2TZwLHwa5EIYH3u7TvsKcNXpomX0fO4m2UkbO?=
 =?us-ascii?Q?iDHVIity/LmnJyj0AgKPyr2ZaY+HPnLCvHyzFF+4KFztCCSbdujwzShmSE2u?=
 =?us-ascii?Q?ESRHkqG7OqcOaBYazk9vCy/m6rj0rtZTCcZQAHGuXv3JgSRVB7sPWJEKJLxp?=
 =?us-ascii?Q?zUdu1YYYq0vM5gWiOD6Zwj4XS5GZ1V4S6vqS1jrXmdh+247v0Ye26uJDQjaM?=
 =?us-ascii?Q?oCe1EYfWaNA1pe7Rpfki1XbnAH3yRtYnTh8XVfE6nBjDcltUz5ceWGF229vZ?=
 =?us-ascii?Q?j/XPsz3N2c5TDKn7N/Cyxh0TfcOzwpfzoCAdzm3esZKqHEGD8GSW2IwBHnUW?=
 =?us-ascii?Q?VdAq6dAnCSdhOtHVgLGVRNGwjxy/7WwBR4+TikZhZl4ZB3NimUZUeriRWjC+?=
 =?us-ascii?Q?x+w2STfNueTNWm7bw43io9sGT4gadsrKleFXKL9IMcC5ocEC6xp7uvUTYuDq?=
 =?us-ascii?Q?yxsn7lybUtsuEgQR8EwQRhKno+rcWeGqo1wfn7faRkvOz8/VSuuk/oSvK5y5?=
 =?us-ascii?Q?eh7K2s+49aWZg6VVmOmLavGCmOYF9jiM5LVyYZ+cyViEIueJ1loT5xAzj+a3?=
 =?us-ascii?Q?qqknGo1t/OQxejyZ6PNf2m6s7PNBPkqYlxK5/EDVmrihcWBuDeNZlcRpqtpF?=
 =?us-ascii?Q?OscHnDCsPbgG6jitzyJjAkC4uJKw0OfuI2Hk9d1mXMcXykPaq3wjjYHNUO6R?=
 =?us-ascii?Q?MS4wN/a4MnVEaXc58UUtRQMOkSZ0/6VSDSguqYyD?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930BB63A500C4E548B697FD97889DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38912402-56e5-4701-dc94-08d99bb6c04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2021 15:05:46.1962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9NGdajg3Qs5WIbKaoq6YzRfC9hUQeeizfV+s2MWvtrCgguidn5oUG0clVQ09mMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB3930BB63A500C4E548B697FD97889DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

For swsmu, we could add a helper macro like smu_is_supported(x) that checks=
 if ppt func is not NULL.

Thanks,
Lijo

--_000_DM6PR12MB3930BB63A500C4E548B697FD97889DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
For swsmu, we could add a helper macro like smu_is_supported(x) that checks=
 if ppt func is not NULL.</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_DM6PR12MB3930BB63A500C4E548B697FD97889DM6PR12MB3930namp_--
