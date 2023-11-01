Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA9C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 02:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7690110E60E;
	Wed,  1 Nov 2023 02:34:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C093410E60E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 02:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWM8pTH2piMx76Weh959r9YtKi7TnUDqKvej0Gykv9XFZzbXSe+WAjhhiQgbVn8/tUfM+Or7SdvPB4O/LlZRQx1G2J/1P8OYqYnXAyPiLcp/EKWuqb7tUIPCaylre3gocEFMMUR0mYOXNauJ1uaSF//5LgnPOOBeHiopbn4Tkmm30XrlTQh0kkTZsItPJCdQVq8Qj+YfPbwqxYar1IiOY4tCn5xJorX8A5U0tePh2Bd5xLflWITiQOrwqRbb2USoTW2HyNbOoq+izL83Vi1fyUMJsSwJKL/tyQlBUcmYNjuZ1Y5CP3TLDivnhQm6Tmqtr7nOnANEs7g7windO28TIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrcqX27Er/6VH/BMWd52+a86zjcT3e+TP3B3TsmbsgU=;
 b=oaMZUm9NI2OtzoH9TnzzF9FG+ZjGqz4ENpP7NUzVN2bKE7Lb7T8PjknD5JzSRPm/mNFLDYU29lHPI3HTbuyzipaW03qOJWNfN0ERGRNvtFZATF7/7hMLQjXmevjNeOb6lGgZtHu3Cw4nhArBqIdgq0+ktMEXlRSAPtkS8j4K46NJ0dheiZTlzNm9upo4Rv/kQ8oEUPq+TX5IbeFSejDxDYuJLGu4SGqdIIbKCqkbZ1sdZuL3bB0qZ/A6BlNnasNbi3FmAPgjpNxdKxnaMKtJtjijg4l8JpA5iw5DUD0mZvD0A/WGhZfOBr0gebQ4ua+JUmdY9XSw2AdOKUqGafi3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrcqX27Er/6VH/BMWd52+a86zjcT3e+TP3B3TsmbsgU=;
 b=NIfdAs6Xr1S0qbT7k3Wer6MLuJDeavwZapCnFu7/KCO2NP0vyed68zLetHMNKApfiMyh4XSQY3iFTDjIYGlNngazCwKWLZyjCxfnlH/ni1essebNZi8aX+YyPJo3y7WkmeqXWVSUqJ13MUZh57fT+Nct3QmoCDuODWsfzsmXxzM=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 1 Nov 2023 02:34:36 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6933.028; Wed, 1 Nov 2023
 02:34:36 +0000
From: "Ma, Jun" <Jun.Ma2@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Recall: [PATCH 2/2] drm/amdgpu: Fix the the asic type of some new
 asics
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix the the asic type of some new asics
Thread-Index: AQHaDGv0ryj2mtReU0mz09ognFZRoA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Wed, 1 Nov 2023 02:34:36 +0000
Message-ID: <DM4PR12MB63510DBC5D8EFC8C7736A159BCA7A@DM4PR12MB6351.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SN7PR12MB7275:EE_
x-ms-office365-filtering-correlation-id: c24e4c79-a9ee-4228-a049-08dbda8316d2
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ucbb2y7L1fcwo7xah4YfFTkLqOLsQZBcqpS37uBqQ5i24IiWKktIrzBX4CjVSXWRqwBEC2uEiAdrXEeearjWFN1yCbqW67VeHDJvV54O8HCz3sMuIEI2B4886opRE2TA37IuH/QcW09QVKT4bJxRmHKW+Y2lt58S3iY1ClhEHaJUJqpVqMPpkMTP2tygl3Lpx5ytRj9bedn4WTZD6K0BFWgPrhAy/DBZqou+MgF+CbivgX57ibsbhKXaBLKHLTuSvQqVlWmT+iVpDNp9pXThXlmwOjNSlGIth1QkZukV0Q8T8A4NHf8O9PsJoh9y1ZwH5UCD9UM3lqNXvI5KJex+cXEDHbW+9smpdLljoK8tlTJT7UXIxsw9mK4iQ6/ONxHZYfFPLcOWTLrztFR7I4eE2MACniaxQ0Zyq6hHn7aJp7wPQoNwVB9MYa1xr0ihp4z8I+5hwCUFNvI/r9P16iaeH+ZufObwiojMMk5nZ6wkO+03VEnPKm1uYt9sT3Ufb4IyLaIGyCONtwk+cLAaTNy6bQ0IcfA6lDTud5PrSuqS1FKcpWs8EUWV3D/+O2YwxzawQz173Xo6yLjedrjgYZeM0A2JSwHX6lgy/YPCIoynyG8coPvkkBlvtotv8QPi9Ds
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38100700002)(2906002)(86362001)(4326008)(55016003)(33656002)(64756008)(122000001)(66446008)(66556008)(478600001)(7696005)(9686003)(83380400001)(71200400001)(6636002)(76116006)(66476007)(52536014)(316002)(41300700001)(5660300002)(110136005)(8676002)(8936002)(558084003)(66946007)(38070700009)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66dKXw4MM/RAKR7PkhwhlVXZ5iIJfQFn0uf2vCYzoq/xmC6DuOqsKn1f1HoR?=
 =?us-ascii?Q?bqfW3qOMQPQDZX1cI/SQiqb+Vj2O40P+uuEjespLyoAzQMsyNi2M+7+GqtJN?=
 =?us-ascii?Q?mV/DPcn2GwDMWPS2rzKZnANiY2vWmIne+kEScJOS05yQS2nQc0plptTQQFWy?=
 =?us-ascii?Q?IvyLJSFQsgLodKmXkAH2ch4IXkCOaQo9Mg5Z3dQlT+WAavmPwV2m5g7HhUjF?=
 =?us-ascii?Q?B30eTIzyYYa70CAsQtyl3cwHNyYKj4fLqoE8HAVdD3bT9ItTJaZkfINntiT2?=
 =?us-ascii?Q?4VfXH1qvDLBwLH2vlW7pxFf7l9nbBI2mTDErxMxKitz7LIwGbCGYRJTSG2dN?=
 =?us-ascii?Q?dAsHX4oW3xUWU3JLZuJWj0XKP3Q00R3jFDI8eJspSh2dnmNuScWn0Q5aqAUr?=
 =?us-ascii?Q?d197h9hRcDuD8WuKrGO/xR4IS4yDqaWCOeLzj8Vej6RiuxmYnChvbHGFBvq8?=
 =?us-ascii?Q?uXVioaikvFo3uuSnIKeucH7TJMp3knEIOULda0S1WVonDBk1dhq2s1jCQOPQ?=
 =?us-ascii?Q?AzUzul9UXg96PUdPZ9b70xIrYOrkbUyDm1IyVEBWiFP659fhESslGcGy3CDF?=
 =?us-ascii?Q?Y08LBIoKEjUZ2Wfpr4IZER2aGInImoCrMMZr8F2aPvVh3Mrb6eDjUgSR96vT?=
 =?us-ascii?Q?v6hL+p3akL3z98XH8d+ZkquSTKRA5r2KtMVig70JSHUufPxc/32I0diCp3C5?=
 =?us-ascii?Q?TCaQEQ7jo/DxB0jYAZGfoLwJxYrTh9BAOwoDMN9nLkRcgnT/6j2/yErOlt4W?=
 =?us-ascii?Q?mZx0Kxs7/G9rFfHt2Y5gxWYjWBAa3B/DiVjHW8ZzriEu8ERtUNTJmdFeg8ep?=
 =?us-ascii?Q?g1JO0fehz+pOS/ctJ0NNvHTJ27Y/0fLsJEnziXeVZcduyqiPSACoW6iHOvLq?=
 =?us-ascii?Q?/g0RoN9HuIQU9xFnObUYrfk6Txpg4ydXTABnHocqEyjgOejfydrrwsSCx5YU?=
 =?us-ascii?Q?1hbCpxFZ9qchGL9oj7if/roSUpAycJcPBj8ik5rn+854HNxiEKdg8yU3iPjz?=
 =?us-ascii?Q?xJeYeBwTExTRlFDX+5+lNMhdKHZks5x8Db4vcgywahyDtnqNPdOZ50PWUqZR?=
 =?us-ascii?Q?meIGToTDuBzfgMeOX8Xj/hK6DZtQjB30Q/N8E7cZYRfFdMvO3Fc5+qVf90Gm?=
 =?us-ascii?Q?80FXncCv52A6Dp11xPPVd1EU2p/R0aMc6TiYQRf+r4ekGIRIx1KcKauCWLyk?=
 =?us-ascii?Q?U8t9QeVLT75FoBrGQzEtNQzzs9otavlkxFK7n8O7LI5wGvgTg8DE9bV79YfI?=
 =?us-ascii?Q?rmwW267zMB50PwUVBU5qil8nkyXyNhwL1pSd1ElwdvRbr178Yt4gFq1Gt/GT?=
 =?us-ascii?Q?6HqM+YAKG8wFFhPRFTrj/udTuewmtN/JojnOVj5UPlOOTsrc+0V3SQYa9FUa?=
 =?us-ascii?Q?WCDSmYz7BF7ToMfhBLAeMqHPUXwY2wnKuWrM/N04a0oMiFA+IIWeUKOJTu+M?=
 =?us-ascii?Q?rU3cICrG7oGwp5cWL7jI0/YTcic+vVZnX6f1IOPtkZK7HQ82P5D8Bx/6uE51?=
 =?us-ascii?Q?fCdh13vtIhbxjOAfUpZRZUDFiX4o7HLK17gVBZc522/NulTsrMWWOmHutfSb?=
 =?us-ascii?Q?ug1W+oDGSiPPEqy0Xls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24e4c79-a9ee-4228-a049-08dbda8316d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:34:36.1364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0pRMSZlHX1Ts87vkWJFe52S68whjIK6xBHBHTDJ4QFfoleW/HxZfmemiBR9FqeR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ma, Jun would like to recall the message, "[PATCH 2/2] drm/amdgpu: Fix the =
the asic type of some new asics".=
