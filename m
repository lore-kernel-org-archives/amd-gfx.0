From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH] Add GPU_POWER sensors
Date: Sat, 11 Feb 2017 11:56:51 +0100
Message-ID: <5e4561d2-b937-0ebd-e895-6c5d374ea93a@dev.carbon-project.org>
References: <20170210181027.16113-1-tom.stdenis@amd.com>
 <20170210181027.16113-2-tom.stdenis@amd.com>
 <909a2650-cafc-6be2-6bf6-8b57f0edecc4@folklore1984.net>
 <ac9b9ef1-5ffc-e299-5ee1-980181891ef7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863152890=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ac9b9ef1-5ffc-e299-5ee1-980181891ef7-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Edward O'Callaghan <eocallaghan-00lIPu45W7RWsFX2Gss+EQ@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1863152890==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="D2R6TThfeBBAqST9lHlbaXi0cDbOkgjs2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D2R6TThfeBBAqST9lHlbaXi0cDbOkgjs2
Content-Type: multipart/mixed; boundary="fADw3nTTJsglkskmC7wAUetjW337IFu9k";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>,
 Edward O'Callaghan <eocallaghan-00lIPu45W7RWsFX2Gss+EQ@public.gmane.org>
Message-ID: <5e4561d2-b937-0ebd-e895-6c5d374ea93a-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH] Add GPU_POWER sensors
References: <20170210181027.16113-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20170210181027.16113-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <909a2650-cafc-6be2-6bf6-8b57f0edecc4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <ac9b9ef1-5ffc-e299-5ee1-980181891ef7-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <ac9b9ef1-5ffc-e299-5ee1-980181891ef7-5C7GfCeVMHo@public.gmane.org>

--fADw3nTTJsglkskmC7wAUetjW337IFu9k
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Tom,
Tom St Denis wrote on 11.02.2017 02:02:
> On 02/10/2017 07:25 PM, Edward O'Callaghan wrote:
>> Hey Tom,
>>
>> On 02/11/2017 05:10 AM, Tom St Denis wrote:
>>> Add the ability to sample GPU_POWER sensors.  Because
>>> the sensors have a high latency we read them from a background
>>> thread which means we've added the requirement for pthreads.
>>>
>>> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  CMakeLists.txt         |  5 ++-
>>>  README                 |  6 ++--
>>>  src/app/top.c          | 88 ++++++++++++++++++++++++++++++++++++++++=
+---------
>>>  src/lib/CMakeLists.txt |  1 +
>>>  src/lib/read_sensor.c  | 37 +++++++++++++++++++++
>>>  src/umr.h              |  5 +++
>>>  6 files changed, 123 insertions(+), 19 deletions(-)
>>>  create mode 100644 src/lib/read_sensor.c
>>>
>>> diff --git a/CMakeLists.txt b/CMakeLists.txt
>>> index ef78c97ad763..7b771d01919b 100644
>>> --- a/CMakeLists.txt
>>> +++ b/CMakeLists.txt
>>> @@ -19,6 +19,9 @@ add_definitions(-DUMR_BUILD_REV=3D\"${GIT_REV}\")
>>>  # Add local repository for FindXXX.cmake modules.
>>>  SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_modules/"
>>> ${CMAKE_MODULE_PATH})
>>>
>>> +find_package(Threads REQUIRED)
>>> +include_directories(${THREADS_INCLUDE_DIRS})
>> Do you need this include_directories() line?
>>
>>> +
>>>  find_package(Curses REQUIRED)
>>>  include_directories(${CURSES_INCLUDE_DIRS})
>>>
>>> @@ -37,7 +40,7 @@ set(REQUIRED_EXTERNAL_LIBS
>>>  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
>>>
>>>  # CFLAGS +=3D -Wall -W -O2 -g3 -Isrc/ -DPIC -fPIC
>>> -set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -W -O2 -g3")
>>> +set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread -Wall -W -O2 -g3")
>> You don't really want to have your linkage flags here, I think your
>> looking for ${CMAKE_THREAD_LIBS_INIT} to go into the
>> REQUIRED_EXTERNAL_LIBS list.
>=20
> How does it "go into"?  Simple '+=3D'?
>=20
> Can you just send a quick patch I can squash into this?  The less I kno=
w about
> cmake the more room I have in my head for useful things :-) hehehe.

1. You might want to set
  set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
at before the find_package() for Threads
2. Linking usually happens through target_link_*() calls, where you would=
 add
Threads::Threads (special thing created by FindThreads.cmake) to the list=
 of
your other variables.

See <https://cmake.org/cmake/help/v3.7/module/FindThreads.html> for detai=
ls on
how FindThreads.cmake works. In your case you might want to set
THREADS_PREFER_PTHREAD_FLAG as well.

Cheers,
Kai


--fADw3nTTJsglkskmC7wAUetjW337IFu9k--

--D2R6TThfeBBAqST9lHlbaXi0cDbOkgjs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlie7fMACgkQownXbOHe
WdK2zwv/XB5N1wjofljybKjXAPVpn02gimhpOGAa0EdD5FzNBguYYdKk4BwIYeoo
KptkXG6LZcq0rOzK02HNgFa1rqA8yCsyk+4I8TfocDFQo/MAv2cWtS9tpq3eVx9Q
0TVWOHoYNOXou2cxZvbFET02idClZSuH8a0yyY99vo+WvzoIIxfpT9QpI4BbQEf8
7Nu3ZYwrAMB2vgLsn4hnUgy/WkPFkY1258Tau0mIzb8y3s9GUpwRVkvMTO3AoCt3
05byd4EJU7L9tXt6yJfAZwW/K4lo1dW2uGi/tD9WCyz2sSix50Khw3XciH3vt0HG
MdZDyIM/o4XPg8X+AKyLg6iLybB51K5MWPNrllLptI8Yq3JGLCML8yyW6L9j9PoQ
NEZP/aTX5ILrTcAAgGEgnmcl0+FpCxHl6iCTjUkrUnMLgPnd219IDeHIMU4OQ1tB
P2dwQeU1JTty9JDpu6Q5vvc/Tr2WZeKWWFjVZCQ8KwKIf03mHfRlMFaEyicgtstg
qmOfv6Td
=4kuu
-----END PGP SIGNATURE-----

--D2R6TThfeBBAqST9lHlbaXi0cDbOkgjs2--

--===============1863152890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1863152890==--
