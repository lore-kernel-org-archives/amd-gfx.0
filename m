Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D1C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 02:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DEF10E53D;
	Wed, 25 Oct 2023 02:33:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D0F10E53D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 02:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVuBaH1QgFbofwgxa+KN1UB1nhNznPmS6wYDYmMcyn66GmRYp3ui2FkaWJIphnliiXdKrvnxhyW/hjtWnB2+gfViOAtcjxrArLAQOipkkG3ah6nYJbNDeNpoyv0l4pwwL81Vvm45aJmKj+kzFoOhG3ixprOqQdf5R/jJ7c8xQMP5XvaWP+QC1aZU2Xh983BPncX0lcScfrvJXXcaB8yX3B333mKG0H2b1qc8NdUWYMOAc+rXzLjoiKWqe5UReAFT/LA0xwTdql7S0P9xGuSvPyKc0OopC1uhFXjGhS3BqBk3Ytnv/uIVrfAh3AsrJUZPJ7HCSF/BndDaW7zUEOKNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O27KNwLLlrCwWQ8h7z9JelURYm7JqzbuNwZKPLWvt8A=;
 b=cYt3aqvK4ET86pQMskV7n8vMZBFeuQ3uQkIZkaGY+woWEhcf5kjE//L4GA4/zpMkj5DZCoGducW7Si4ndsqizump+zo4Z4n4QxRGjioOHqN3Th4Sxm0EY/AkywGZupUnvKuWNG1dB1v0YvtZQZOMENkFf11P7mgX/cghF5LJhDkP6/raqLi4avU7Zs7sA0BtG95x2Wai1/P2kyCBMgDhlDFdKXjWgep6DHo06V4HWzE3smV26BA0WiW9l+Wg6NboFC1ujxBuxNuRdtnLpBCtkuSeXrTR/buDp8IY2rBzJ5SX5w6T4wYNybW/YZ/7TlNi0VrYu617J//8XB7CYTng7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O27KNwLLlrCwWQ8h7z9JelURYm7JqzbuNwZKPLWvt8A=;
 b=Rdh6Mv7impaKKStS0I7CahjW/NHvE+FhjiP0vfsrjpuv7vAxm4F6S2lBj0A+z1AIHMkwA3Tjov8Y8aSdS/phouqV3sgtCrs/FaRvYyVn4tw6dwLhfcYIn05MxXPsk0ATYH3Ds7bA+wuZTbNTJlOdq+1M5hTzzbQSQgHgtxCRnv0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 02:32:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 02:32:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/amdgpu: fix the GPU power print error in pm
 info
Thread-Topic: [PATCH v2] drm/amd/amdgpu: fix the GPU power print error in pm
 info
Thread-Index: AQHaButMtEBw7j3R1E6kMi8I5rXNF7BZySUQ
Date: Wed, 25 Oct 2023 02:32:56 +0000
Message-ID: <CY5PR12MB63696158F8630E4B17950193C1DEA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231025023045.343239-1-li.ma@amd.com>
In-Reply-To: <20231025023045.343239-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=df3002c8-72ba-44d3-90e7-c93bf020d9ab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-25T02:32:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ2PR12MB9006:EE_
x-ms-office365-filtering-correlation-id: ec593536-f1eb-4261-c421-08dbd502b285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /a2PvN9loNyJenlmFxggAjLonv6n7+6xWP/MFPHxnHZ1DXUCEbhRuJu3Lg7A8LWBHXBsrsJftcV+wAuj+FrdHAOXfnGLRDD19gU4nZcZPCDDSyvOry6rOeLMwBVkCbPh29klM4l6/GfbLgJqWtRZCeSiKM7u9jAODepvuFIEGHfPEdcxV7o8oR7FoDzwkDDMFnSHv2g207QdxfS1ap2IXmCc3+j4dTUm+emZwEK2/znyqY6FNbehxkdkUn/nFq2o+uaQbrD1rTiAV3gUlERQghA2uGb16ksOeOlawdTOHwyFKpG/ZLNoK6/d+4ta4Kfx7IZD6oYGuxhPIfamX+Y4B62fgOuQqRW8T3D2Ki9IUqA5sshQKIPd3HYkPj4/eYbnwlNxhpke4SSPFvKHMvBZOuJjj15rLjZqvh7tiNhzUWgFjPY9kbaWHzKSDIJLvwMOjW6G/I+Tww1ddvUYHowYcS50oJPIcwNbmlwLQww1BQgpA4roOCzobxyJEfadP5zYCNb8j7BQL6Mo1yqkE6yTqcC6AvixwZQyYU9qab2z8r9HP6KmaMCyAvN5GNOiyZbEzewJcaJ6YbA5JQPz5rMk3D44sZMUFWjCpCJR7COzVq3Vn7+lF6p3vW4wdXTyJZ0o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33656002)(2906002)(55016003)(5660300002)(4326008)(52536014)(8676002)(38070700009)(66446008)(66476007)(8936002)(41300700001)(66556008)(110136005)(86362001)(9686003)(76116006)(478600001)(66946007)(71200400001)(6506007)(316002)(53546011)(7696005)(26005)(54906003)(64756008)(122000001)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UYa6SGSoW+flAvX50R6UKtAXwPXDcAxovXzu9WDFrcNFBad/RtLLRqjreS99?=
 =?us-ascii?Q?90GEFytbaniiiFzpKqRCE/eanogIYXdpC9HtaXhGj3KqOerAkeyjrnRJVgmH?=
 =?us-ascii?Q?64yGoEBSBQOe0/JUFafXqQbnimK+On8yW1k2TBwuNewavyKYJKiZYquys7OI?=
 =?us-ascii?Q?cOnoAe7pg8Kycutz7kNNplsDMCoDk66AuWZS+TTGwmRB8JRuMKOiRxUh5/8f?=
 =?us-ascii?Q?2yO96Ac79cOfa5FNL0DNrcOlDhe0jtTn/EqI/gExGhFTYfRqeLhZVI+6SVEs?=
 =?us-ascii?Q?5ttIyRKsSek5EFqLfb7sm79monx690mlu2ijJwxaOuQzIudbGY45T9oD1hL9?=
 =?us-ascii?Q?TVjpKbkado85jzwq0xCwaACp4QZuWXJgQ1pSRWlBANIjY34K6beJYvXIjaih?=
 =?us-ascii?Q?7esJGvTRP3fTEWWNGbu/atJJFhvLfl3L1YXvZtBUJKD415cOXnZ7l6iJhYpm?=
 =?us-ascii?Q?pBCLT80TaOAjyMkBSfObxhCaaQMTM4p4edQjXzeeMU2Ob1JF9xefAuyerl7K?=
 =?us-ascii?Q?Vtiz5t/MD95qhwQtW/JzV5XH5XWCCfxlarWPOFW4a/JarGt5Y/8NLfhZ+LdW?=
 =?us-ascii?Q?YagjMk4dL6OQY5PjSLUV72hpE4oWsixn8wHJx5bv1X6YZIe5ogqegNoJa+rf?=
 =?us-ascii?Q?zJGNBvSV+h60oa4cWbSy0q+2QeA/MyTH57JH+zJz4sqYtYJaV79/jXA2ssBw?=
 =?us-ascii?Q?HKnj8+QO8yu5MQ3yqN3iBtQRn5v5YawKlDjJxhn4J1kFz4ho2gdQI1PhOjvR?=
 =?us-ascii?Q?PLbEUIMVHxvEDXJiUs/R/z4jlEN46gM+fopzmH+Fw1eJQAjmbZi10H2XVHx5?=
 =?us-ascii?Q?MEjsLaFm7SDxw9avDeOw4m3YRyHXtzi3gsmwToRkXRsQ4PjalFHo+BO+spZ6?=
 =?us-ascii?Q?oNElSgeIlhEtG63Kb0nM4lHXHDfwtyRAY+udYx2ZWwRNPJgAeiBdfMiDNxyz?=
 =?us-ascii?Q?ItUyZ3ZXpT3opA5eSMcb3FO9pgL+wq0q0Oiq1vLeGC+IQVys9fgIyikO9KKs?=
 =?us-ascii?Q?psW7KB5tSEWc7sqqM6A3jk3kAkNzlrrY8axKXSUiNjy3agIjqA8gEXaCV9B1?=
 =?us-ascii?Q?L6Djp7ubBtMES7LnHcP6j6N3Rky80sjPLManhWRjW9MmqheFLPbsy2s6qIFD?=
 =?us-ascii?Q?XsJcq9GaZci9PkgvnuEZiw7ePn3sEEpOoO0sPnQ9OX1mRa9eZz5UAyznkQdv?=
 =?us-ascii?Q?POAEVrk7vLMb68LgSeiFpEYo7NCoL3PGOJwnmKJqD2G+yzUu+uuRkRbpl4DX?=
 =?us-ascii?Q?AptSOVyqf7vhqgHKrrUUTRWRpybFSo2qhMJ+w/bXIZWP1C08aqafGsVjoAKN?=
 =?us-ascii?Q?X+C4qwAORJe9evOLw0O2FEy6PTl59Ve2teWRsc+RvzmzmV7rup23IXo5BNY7?=
 =?us-ascii?Q?s74IFSc04Ni2J58RvawGOWYMXz0s6QaYhhTpkVw6fnh8PxQQnKTrceRnTKhr?=
 =?us-ascii?Q?w7rL/xpemWE7MuXmr7O3aqGHvr+QW4+gQO/dAXtHu1qe6LPBMhAhLIKmXxuB?=
 =?us-ascii?Q?eRUAouAKYtubK/dmAcjAVrj2IwW6M/HBKA0nWogl3kdQYlb/Z6XSj5CRIPQ9?=
 =?us-ascii?Q?7dawtdsPnbeoZ8C1Meg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec593536-f1eb-4261-c421-08dbd502b285
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 02:32:56.4245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2eYQY0EpqzRdtKR1gTM661DdEe3pgbaU52Mc5pGUE0qsEHS3rIo7njCkHUM8TC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Wednesday, October 25, 2023 10:31 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Yifan <Yifan1.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: fix the GPU power print error in pm inf=
o

Modify the print format of the fractional part to avoid display error.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 358bb5e485f2..517b9fb4624c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,10 +4290,10 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fil=
e *m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%02u W (average GPU)\n", query >> 8, qu=
ery & 0xff);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%02u W (current GPU)\n", query >> 8, qu=
ery & 0xff);
        size =3D sizeof(value);
        seq_printf(m, "\n");

--
2.25.1

